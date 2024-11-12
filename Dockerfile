# Use an official Python runtime as a parent image
FROM python:3.10-slim  

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file from the root directory of the project
COPY requirements.txt /app/

# Copy all application code into the container
COPY . /app/

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

# The credential file will be dynamically injected at runtime
ENV GOOGLE_APPLICATION_CREDENTIALS="/app/ayoba-recommendations-engine.json"

# Run app.py when the container launches
CMD ["python", "app.py"]
