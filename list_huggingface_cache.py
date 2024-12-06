import os

# Define the Hugging Face transformers cache directory
cache_dir = os.path.expanduser("~/.cache/huggingface/transformers")

# Traverse the cache directory and list all subdirectories
for root, dirs, files in os.walk(cache_dir):
    for name in dirs:
        print(os.path.join(root, name))
