# Use the official Python 3.10 image based on Alpine Linux, a lightweight distribution
FROM python:3.10-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Prevent Python from writing .pyc files to disk
ENV PYTHONDONTWRITEBYTECODE=1

# Prevent Python output from being buffered (ensures real-time logging)
ENV PYTHONUNBUFFERED=1

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Copy the requirements file to the working directory
COPY ./requirements.txt /usr/src/app/requirements.txt

# Install dependencies from the requirements file
RUN pip install -r requirements.txt

# Copy the entrypoint script to the working directory
COPY ./entrypoint.sh /usr/src/app/entrypoint.sh

# Copy the entire project directory to the working directory
COPY . /usr/src/app/

# Set the entrypoint script to be executed when the container starts
ENTRYPOINT [ "/usr/src/app/entrypoint.sh" ] 

# Define the default command to run the Django development server
CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000"]
