FROM python:3.11-slim

# Install dependencies
RUN apt-get update \
    && apt-get install -y build-essential curl wget git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements.txt first for better caching
COPY requirements.txt requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose port 8501
EXPOSE 8501

# Set the entry point to the Streamlit app
ENTRYPOINT ["streamlit", "run", "--server.port=8501", "--server.address=0.0.0.0", "stream-diabetes.py"]
