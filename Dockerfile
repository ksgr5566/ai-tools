# Using anibali as the base image
FROM anibali/pytorch:2.0.0-cuda11.8-ubuntu22.04

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

# Set the entrypoint for the container
ENTRYPOINT ["hypercorn", "api", "-b", "0.0.0.0"]

# Expose additional ports for Gitpod
EXPOSE 8888
