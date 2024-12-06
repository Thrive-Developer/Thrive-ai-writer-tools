# AI Writer Tools

## Installation Guide

### Prerequisites
Before you begin, ensure you have the following installed on your system:
- Python 3.8 or later
- pip (Python package manager)
- Virtual Environment module (`venv`)
- Git (for cloning the repository)

---

### Step 1: Clone the Repository
1. Open your terminal and clone the repository:
   ```bash
   git clone https://github.com/devthrive/Thrive-ai-writer-tools.git
   ```

2. Navigate to the project directory:
   ```bash
   cd Thrive-ai-writer-tools
   ```

---

### Step 2: Set Up Virtual Environment
1. Create a virtual environment:
   ```bash
   python3 -m venv venv
   ```

2. Activate the virtual environment:
   ```bash
   source venv/bin/activate
   ```

3. Upgrade pip to the latest version:
   ```bash
   pip install --upgrade pip
   ```

---

### Step 3: Install Dependencies
1. Install the required dependencies:
   ```bash
   pip install -r requirements.txt
   ```

---

### Step 4: Run the Application
1. To run the AI Writer Tools module:
   ```bash
   python run.py
   ```

---

### Troubleshooting
- If you encounter the error `No module named ai-writer`, ensure that:
  - The `ai-writer` package is properly installed in your virtual environment.
  - You have activated the virtual environment (`source venv/bin/activate`).
  - You have installed dependencies from `requirements.txt`.

- If the error persists, try reinstalling the dependencies:
  ```bash
  pip install --force-reinstall -r requirements.txt
  ```

---

### Additional Commands
- **Deactivate Virtual Environment**:
  ```bash
  deactivate
  ```

- **Remove Virtual Environment** (if you need to reset):
  ```bash
  rm -rf venv
  
