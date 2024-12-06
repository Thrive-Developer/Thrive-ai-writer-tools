from diffusers import StableDiffusionPipeline, DPMSolverMultistepScheduler

# Inisialisasi pipeline sekali
pipe = StableDiffusionPipeline.from_pretrained(
    "stabilityai/stable-diffusion-2",
    use_auth_token=True
)
pipe.to("cpu")  # Atur ke CPU jika tidak memiliki GPU
pipe.enable_attention_slicing()  # Optimalisasi memori

# Gunakan scheduler yang lebih cepat
pipe.scheduler = DPMSolverMultistepScheduler.from_config(pipe.scheduler.config)

def generate_image(prompt, output_size=(256, 256)):
    """
    Generate an image using a pre-initialized pipeline.
    :param prompt: Text prompt for the image
    :param output_size: Tuple of (height, width) for the output image resolution
    """
    try:
        # Atur ukuran gambar
        pipe.height = output_size[0]
        pipe.width = output_size[1]
        
        # Generate image
        image = pipe(prompt, num_inference_steps=20).images[0]
        file_name = f"{prompt.replace(' ', '_')}.png"
        image.save(file_name)
        print(f"Image saved as {file_name}")
    except Exception as e:
        print(f"Error generating image: {e}")

generate_image("A futuristic cityscape at sunset")
generate_image("A forest landscape with a flowing river")
