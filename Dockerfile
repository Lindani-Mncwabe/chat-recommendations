# Use an official Python runtime as a parent image
FROM python:3.10-slim  

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and the project into the container
COPY requirements.txt /app/
COPY . /app/

# Set the environment variable for Google Application Credentials
ENV GOOGLE_APPLICATION_CREDENTIALS="/app/ayoba-recommendations-engine.json"

# Install system dependencies required for building certain Python packages
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install the dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable for Flask
ENV FLASK_APP=app.py

# Run app.py when the container launches
CMD ["python", "app.py"]
