# Using anibali as the base image
FROM anibali/pytorch:2.0.0-cuda11.8-ubuntu22.04

# Install Git
RUN apt-get update && apt-get install -y git

# Set the working directory to /app
WORKDIR /app

# Copy the poetry.lock and pyproject.toml files to the working directory
COPY poetry.lock pyproject.toml /app/

# Install dependencies using Poetry
RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev --no-root

# Download Spacy model
RUN python -m spacy download en_core_web_sm

# Copy the rest of the application code to the working directory
COPY . /app/

# Expose the necessary port(s) for the application
EXPOSE 8000
