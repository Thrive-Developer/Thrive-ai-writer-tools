from flask import jsonify, request
from transformers import pipeline
from langchain_huggingface import HuggingFaceEmbeddings, HuggingFacePipeline
from app.services.client_service_db import ClientService
from app.model.model_from_db import QAModelFromDB
from langchain_chroma import Chroma
from langchain_core.documents import Document

def chatbot_with_user_input():
    # Initialize ClientService to access the database
    client_service = ClientService()

    # Input category and question from user
    category = input("Enter category: ").strip()
    question = input("Enter your question: ").strip()

    # Validate inputs
    if not category or not question:
        print("Category and question must not be empty.")
        return

    company_id = 1  # Replace with appropriate company ID

    # Fetch data from `rag_source` table using `fetch_document_company`
    try:
        documents = client_service.fetch_document_company(company_id, category)
        if not documents:
            print(f"No documents found for company_id={company_id}, category={category}")
            return
        print(f"Retrieved {len(documents)} documents for company_id={company_id}, category={category}")
    except Exception as e:
        print(f"Error fetching documents: {e}")
        return

    # Process documents for Chroma and initialize retriever
    embedded_documents = [Document(page_content=doc["question"], metadata={"answer": doc["answer"]}) for doc in documents]
    embedding_function = HuggingFaceEmbeddings(model_name="sentence-transformers/all-mpnet-base-v2")
    vectordb = Chroma(collection_name="rag_faq", embedding_function=embedding_function)
    vectordb.add_documents(embedded_documents)
    retriever = vectordb.as_retriever()

    # Initialize LLM and QAModelFromDB for RAG
    hf_pipeline = pipeline("text-generation", model="EleutherAI/gpt-neo-125m", max_new_tokens=50)
    llm = HuggingFacePipeline(pipeline=hf_pipeline)
    qa_model = QAModelFromDB(retriever=retriever, llm=llm)

    # Generate response for the user-input question
    print(f"\nCustom Query: {question}")
    try:
        # Pass the question directly to the pipeline
        response = hf_pipeline(question)[0]['generated_text']
        return jsonify({"question": question, "response": response}), 200
    except Exception as e:
        print(f"Error generating response for query '{question}': {e}")

# Run the chatbot
if __name__ == "__main__":
    chatbot_with_user_input()
