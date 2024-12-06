import csv
import io
import requests
import langid
from flask import jsonify, request, Response
from app.services.logging_service import LoggerService
from app.middleware.token_verify import TokenService
from transformers import pipeline, M2M100Tokenizer, M2M100ForConditionalGeneration
from datetime import datetime
from app.config import Config
from langdetect import detect
import os

logger_service = LoggerService()
logger = logger_service.get_logger()
token_service = TokenService()

class RouteLogic:
    def __init__(self):
        logger.info("Initializing RouteLogic...")
        self.model_emosi_detect = pipeline("text-classification", model="j-hartmann/emotion-english-distilroberta-base")
        self.company_id = None
        self.model_name_translate = "facebook/m2m100_418M"  # Model multibahasa
        self.tokenizer = M2M100Tokenizer.from_pretrained(self.model_name_translate)
        self.model = M2M100ForConditionalGeneration.from_pretrained(self.model_name_translate)

    def translate_to_english(self, text):
        """
        Menerjemahkan teks ke bahasa Inggris menggunakan Facebook M2M100.
        """
        try:
            source_language = self.detect_language(text)
            if source_language == "en":
                logger.info("Text is already in English, no translation needed.")
                return text  # Tidak perlu terjemahkan jika sudah dalam bahasa Inggris

            # Set bahasa sumber dan target
            self.tokenizer.src_lang = source_language
            tokens = self.tokenizer(text, return_tensors="pt", padding=True, truncation=True)
            translated_tokens = self.model.generate(
                tokens.input_ids,
                forced_bos_token_id=self.tokenizer.lang_code_to_id["en"]
            )
            translated_text = self.tokenizer.decode(translated_tokens[0], skip_special_tokens=True)

            logger.info(f"Translated to English: {translated_text}")
            return translated_text
        except Exception as e:
            logger.error(f"Error during translation to English: {e}")
            return text  # Fallback ke teks asli jika terjadi error



    def translate_to_user_language(self, text, target_language_code):
        """
        Menerjemahkan teks dari bahasa Inggris ke bahasa asli pengguna menggunakan Facebook M2M100.
        """
        try:
            self.tokenizer.src_lang = "en"  # Bahasa sumber adalah Inggris
            tokens = self.tokenizer(text, return_tensors="pt", padding=True, truncation=True)
            translated_tokens = self.model.generate(
                tokens.input_ids,
                forced_bos_token_id=self.tokenizer.lang_code_to_id[target_language_code]
            )
            translated_text = self.tokenizer.decode(translated_tokens[0], skip_special_tokens=True)

            logger.info(f"Translated to user language ({target_language_code}): {translated_text}")
            return translated_text
        except Exception as e:
            logger.error(f"Error during translation to user language: {e}")
            return text  # Fallback ke teks asli jika terjadi error


    def detect_language(self, text):
        """
        Deteksi bahasa input menggunakan langid.
        """
        try:
            lang, confidence = langid.classify(text)  # Deteksi bahasa dengan langid
            logger.info(f"Detected language: {lang} with confidence {confidence}")
            return lang
        except Exception as e:
            logger.error(f"Error detecting language: {e}")
            return "en"  # Default ke bahasa Inggris jika gagal
    
    def get_emotion(self, text):
        """Mendeteksi emosi dari teks menggunakan model deteksi emosi dan mengembalikan emosi serta probabilitasnya."""
        # Menjalankan model untuk mendeteksi emosi
        emotion_result = self.model_emosi_detect(text)
        
        # Memeriksa emosi dan probabilitasnya
        for emotion in emotion_result:
            if emotion['label'] == 'anger' and emotion['score'] >= 0.61:
                return 'anger', emotion['score']
        
        # Jika tidak ada emosi anger yang terdeteksi atau skor di bawah 0.61, kembalikan None
        return None, 0

    def is_english_question(self, text):
        """Menentukan apakah teks input adalah pertanyaan dalam Bahasa Inggris."""
        # Menggunakan deteksi bahasa untuk memeriksa apakah teks tersebut dalam bahasa Inggris
        try:
            language = detect(text)  # deteksi bahasa menggunakan langdetect
            return language == 'en'
        except Exception as e:
            logger.error(f"Error detecting language: {e}")
            return False


    @token_service.token_required
    def chatbot_content(self):
        """API endpoint to process a CSV file with keywords and fetch responses from Gemini API."""
        if 'file' not in request.files:
            return Response("<h1>Error</h1><p>No file provided in the request.</p>", status=400, mimetype='text/html')

        file = request.files['file']
        if not file.filename.endswith('.csv'):
            return Response("<h1>Error</h1><p>Only CSV files are allowed.</p>", status=400, mimetype='text/html')

        try:
            file_content = file.read().decode('utf-8')
            csv_data = csv.DictReader(io.StringIO(file_content))

            if 'keyword' not in csv_data.fieldnames:
                return Response("<h1>Error</h1><p>CSV must contain a 'keyword' column.</p>", status=400, mimetype='text/html')

            html_responses = []
            for row in csv_data:
                short_keyword = row['keyword'].strip()
                modified_keyword = f"""
                Buat artikel menggunakan keyword berikut: "{short_keyword}". Artikel ini harus memenuhi kriteria berikut:

                1. Panjang artikel sekitar 400-500 kata.
                2. Gunakan bahasa Indonesia formal tetapi tetap menarik dan mudah dipahami.
                3. Optimalkan artikel untuk SEO dengan menyertakan:
                - Penggunaan keyword "{short_keyword}" di judul, paragraf pertama, dan beberapa paragraf berikutnya secara natural.
                - Subjudul yang menggunakan variasi keyword atau sinonim terkait.
                - Paragraf penutup yang menyertakan call-to-action (CTA), misalnya mengajak pembaca untuk menghubungi perusahaan atau mempelajari lebih lanjut.
                4. Struktur artikel mencakup:
                - **Pendahuluan**: Jelaskan secara singkat keyword dan relevansinya.
                - **Pembahasan Utama**: Bahas manfaat, keunggulan, atau contoh penggunaan keyword ini.
                - **Kesimpulan**: Ringkas poin penting dan akhiri dengan CTA yang mengarahkan pembaca ke layanan atau produk perusahaan.
                5. Gunakan meta title (60 karakter) yang relevan dengan keyword untuk membantu optimasi mesin pencari.
                6. Pastikan artikel menarik, relevan, dan memberikan nilai tambah kepada pembaca.

                Tulis artikel dalam bentuk paragraf yang kohesif dan menarik.
                """

                gemini_response = self.fetch_gemini_response_content(modified_keyword)
                if gemini_response is None:
                    html_responses.append(f"<h5>{short_keyword}</h5><p>No response from Gemini API.</p>")
                    continue

                # Generate image for the keyword
                image_url = self.generate_image(short_keyword)

                # Extract meta title
                meta_title_line = next((line for line in gemini_response.split('\n') if line.startswith("**Meta Title:**") or line.startswith("Meta Title:")), None)
                meta_title = meta_title_line.replace("Meta Title:", "").strip() if meta_title_line else "No Title"

                # Convert markdown to HTML
                formatted_response = gemini_response.replace('**', '<li>').replace('### ', '<h5>').replace('\n', '<br>')

                # Append article with image
                html_responses.append(f"""
                    <div style='margin-top: 3em;'>
                        <h5>{short_keyword}</h5>
                        <h4>{meta_title}</h4>
                        <img src="{image_url}" alt="{short_keyword}" style="width:100%;max-width:600px;" />
                        <div>{formatted_response}</div>
                    </div>
                """)

            # Build final HTML response
            final_html_response = f"""
            <!DOCTYPE html>
            <html lang="id">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Gemini API Responses</title>
                <style>
                    body {{ font-family: Arial, sans-serif; line-height: 1.6; color: #333; }}
                    h3 {{ color: #df3510; }}
                    ul {{ list-style-type: disc; padding-left: 20px; }}
                    li {{ font-weight: bold; }}
                </style>
            </head>
            <body>
                <h1>Gemini API Responses</h1>
                {"".join(html_responses)}
            </body>
            </html>
            """

            return Response(final_html_response, status=200, mimetype='text/html')

        except Exception as e:
            logger.error(f"Error processing chatbot content: {e}")
            return Response(f"<h1>Error</h1><p>{str(e)}</p>", status=500, mimetype='text/html')



    @token_service.token_required
    def chatbot_content_dis(self):
        """API endpoint to process a CSV file with keywords, generate images, and fetch article content."""
        if 'file' not in request.files:
            return Response("<h1>Error</h1><p>No file provided in the request.</p>", status=400, mimetype='text/html')

        file = request.files['file']
        if not file.filename.endswith('.csv'):
            return Response("<h1>Error</h1><p>Only CSV files are allowed.</p>", status=400, mimetype='text/html')

        try:
            # Baca CSV dan validasi
            file_content = file.read().decode('utf-8')
            csv_data = csv.DictReader(io.StringIO(file_content))
            if 'keyword' not in csv_data.fieldnames:
                return Response("<h1>Error</h1><p>CSV must contain a 'keyword' column.</p>", status=400, mimetype='text/html')

            html_responses = []
            for row in csv_data:
                keyword = row['keyword'].strip()
                modified_keyword = f"""
                Buat artikel menggunakan keyword berikut: "{keyword}"...
                """

                # Fetch artikel dari Gemini API
                gemini_response = self.fetch_gemini_response_content(modified_keyword)
                if gemini_response is None:
                    html_responses.append(f"<h5>{keyword}</h5><p>No response from Gemini API.</p>")
                    continue

                # Generate gambar menggunakan RapidAPI
                image_path = self.generate_image_dis(keyword)
                image_html = f"<img src='{image_path}' alt='{keyword}' style='width:100%;max-width:600px;'/>" if image_path else ""

                # Format artikel
                meta_title_line = next((line for line in gemini_response.split('\n') if line.startswith("Meta Title:")), None)
                meta_title = meta_title_line.replace("Meta Title:", "").strip() if meta_title_line else "No Title"
                formatted_response = gemini_response.replace('**', '<li>').replace('### ', '<h5>').replace('\n', '<br>')

                # Tambahkan artikel dan gambar ke HTML
                html_responses.append(f"""
                    <div style='margin-top: 3em;'>
                        <h5>{keyword}</h5>
                        <h4>Judul: {meta_title}</h4>
                        {image_html}
                        <div>{formatted_response}</div>
                    </div>
                """)

            # Kembalikan seluruh artikel dalam HTML
            final_html_response = f"""
            <!DOCTYPE html>
            <html lang="id">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Generated Content</title>
            </head>
            <body>
                <h1>Generated Articles</h1>
                {"".join(html_responses)}
            </body>
            </html>
            """
            return Response(final_html_response, status=200, mimetype='text/html')
        except Exception as e:
            logger.error(f"Error processing content: {e}")
            return Response(f"<h1>Error</h1><p>{e}</p>", status=500, mimetype='text/html')




    def fetch_gemini_response(self, prompt):
        """Ambil respons dari Google Gemini API."""
        api_key = Config.GEMINI_API_KEY
        url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key={api_key}"

        headers = {"Content-Type": "application/json"}
        payload = {
            "contents": [
                {
                    "parts": [{"text": prompt}]
                }
            ]
        }

        try:
            response = requests.post(url, headers=headers, json=payload)
            response.raise_for_status()  # Raise HTTPError for bad responses
            response_data = response.json()

            if "candidates" not in response_data:
                return jsonify({"question": prompt, "response": "I don't know the answer."}), 200

            # Extract the response text
            candidates = response_data["candidates"]
            reply = candidates[0]["content"]["parts"][0]["text"] if candidates else "I don't know the answer."

            logger.info(f"Response from Gemini: {reply}")
            return jsonify({"question": prompt, "response": reply}), 200

        except Exception as e:
            logger.error(f"Error fetching response from Gemini API: {e}")
            return jsonify({"error": "Error fetching response from Google Gemini API.", "details": str(e)}), 500


    def fetch_gemini_response_content(self, prompt):
        """Fetch response from Google Gemini API for a single prompt."""
        api_key = Config.GEMINI_API_KEY
        url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key={api_key}"

        headers = {"Content-Type": "application/json"}
        payload = {
            "contents": [
                {
                    "parts": [{"text": prompt}]
                }
            ]
        }

        try:
            response = requests.post(url, headers=headers, json=payload)
            response.raise_for_status()  # Raise HTTPError for bad responses
            response_data = response.json()

            if "candidates" not in response_data:
                return None

            # Extract the response text
            candidates = response_data["candidates"]
            reply = candidates[0]["content"]["parts"][0]["text"] if candidates else None

            logger.info(f"Response from Gemini: {reply}")
            return reply  # Return the text response directly
        except Exception as e:
            logger.error(f"Error fetching response from Gemini API: {e}")
            return None


    def generate_image(self, keyword):
        """Mengenerate gambar berdasarkan keyword menggunakan API eksternal."""
        try:
            # Terjemahkan jika keyword bukan bahasa Inggris
            if self.detect_language(keyword) != "en":
                translated_keyword = self.translate_to_english(keyword)
                logger.info(f"Translated keyword to English: {translated_keyword}")
            else:
                translated_keyword = keyword
                logger.info("Keyword is already in English, no translation needed.")

            # API request payload
            api_url = "https://ai-text-to-image-generator-api.p.rapidapi.com/realistic"
            headers = {
                "Accept": "application/json",
                "Content-Type": "application/json",
                "x-rapidapi-key": Config.RAPID_API_KEY,
                "x-rapidapi-host": "ai-text-to-image-generator-api.p.rapidapi.com"
            }
            payload = {"inputs": translated_keyword}

            logger.info(f"Sending request to API with payload: {payload}")
            response = requests.post(api_url, headers=headers, json=payload)

            if response.status_code == 200:
                response_data = response.json()
                image_url = response_data.get("url")
                if image_url:
                    logger.info(f"Image generated successfully: {image_url}")
                    return image_url  # Return the URL for use in HTML
                else:
                    logger.error(f"API response does not contain a valid URL: {response_data}")
                    return None
            else:
                logger.error(f"Failed to fetch image from API. Status code: {response.status_code}, Response: {response.text}")
                return None
        except Exception as e:
            logger.error(f"Error generating image for keyword '{keyword}': {e}")
            return None



    def generate_image_dis(self, keyword):
        """Menghasilkan gambar berdasarkan kata kunci menggunakan API RapidAPI."""
        try:
            # Terjemahkan jika keyword bukan bahasa Inggris
            if self.detect_language(keyword) != "en":
                translated_keyword = self.translate_to_english(keyword)
                logger.info(f"Translated keyword to English: {translated_keyword}")
            else:
                translated_keyword = keyword
                logger.info("Keyword is already in English, no translation needed.")

            # API Endpoint dan Header
            url = "https://text-to-image13.p.rapidapi.com/"
            headers = {
                "Accept": "application/json",
                "Content-Type": "application/json",
                "x-rapidapi-ua": "RapidAPI-Playground",
                "x-rapidapi-key": Config.DIF_RAPID_API_KEY,
                "x-rapidapi-host": "text-to-image13.p.rapidapi.com"
            }
            payload = {"prompt": translated_keyword}

            # Request ke API
            logger.info(f"Fetching image from RapidAPI for keyword: {translated_keyword}")
            response = requests.post(url, headers=headers, json=payload)
            response.raise_for_status()

            # Decode binary response (image data)
            image_data = response.content
            logger.info("Image data fetched successfully from RapidAPI.")

            # Simpan gambar ke lokasi permanen
            save_dir = os.path.join(os.getcwd(), "app", "resources", "images")
            os.makedirs(save_dir, exist_ok=True)  # Pastikan folder ada
            image_filename = f"{translated_keyword.replace(' ', '_')}.png"
            image_path = os.path.join(save_dir, image_filename)

            with open(image_path, "wb") as image_file:
                image_file.write(image_data)
            
            logger.info(f"Image successfully saved to: {image_path}")
            return f"/resources/images/{image_filename}"  # Path untuk akses dari HTML
        except Exception as e:
            logger.error(f"Error generating image for keyword '{keyword}': {e}")
            return None
