# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt /app/

# Install any needed dependencies specified in requirements.txt
RUN apt-get update && \
    apt-get install -y build-essential cmake && \
    pip install --no-cache-dir -r requirements.txt --no-binary :all: --install-option="--config-settings" --install-option="cmake.define.USE_OPENMP=OFF"

# Copy the Streamlit app file into the container at /app
COPY app_streamlit_SerotoninAI.py /app/

# Expose the port the app runs on
EXPOSE 8501

# Command to run the Streamlit app
CMD ["streamlit", "run", "--server.port", "8501", "app_streamlit_SerotoninAI.py"]
