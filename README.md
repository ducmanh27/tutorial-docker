# Hello world Docker

Hello world Docker is a tutorial applications for learn Docker.

## Installation Docker
### For Windows OS
Download  [Docker desktop](https://www.docker.com/products/docker-desktop/) for Windows.
### For Ubuntu OS (Linux kernel)

Install using the apt repository.
Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker apt repository. Afterward, you can install and update Docker from the repository.

#### Set up Docker's apt repository:

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

#### Install the Docker packages:

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
#### *Tip: Run Docker without sudo

By default, Docker requires `sudo` to run Docker commands. If you want to run Docker commands as a non-root user, you can follow these steps to configure Docker:

1. Create the Docker group:
    ```bash
    sudo groupadd docker
    ```

2. Add your user to the Docker group:
    ```bash
    sudo usermod -aG docker $USER
    ```

3. Log out and log back in to refresh your group membership.

    Alternatively, you can run:
    ```bash
    newgrp docker
    ```

4. Verify the setup by running:
    ```bash
    docker run hello-world
    ```
This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.

If you had previously used `sudo` with Docker, you may encounter a permission error related to the `~/.docker/` directory. To fix this, run the following commands to adjust the directory's ownership:

```bash
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
```

## Content
### HOWTO run application
#### Clone source code of helloword app
```bash
git clone https://github.com/ducmanh27/tutorial-docker.git
```
**Note for Linux Users:**  
Before building the container, ensure that the executable file in the project has the correct execution permissions. You can grant execution permissions using the following command:

```bash
cd ./tutorial-docker
chmod +x entrypoint.sh
```

**Note for Windows Users:**  
Before building the container, ensure that the executable file in the project has the correct execution permissions. You can grant execution permissions by open git bash (or open file entrypoint.sh by VSCode then save with format LF ):

```bash
cd ./tutorial-docker
sed -i 's/\r$//' entrypoint.sh
```

#### Build docker image
```bash
docker build -t helloword_app .
```
#### Run docker image
```bash
docker run -d -p 8001:8000 --name django_container helloword_app
```

### Example Dockerfile for helloworld app

```Dockerfile
# Use the official Python 3.10 image based on Alpine Linux, a lightweight distribution
FROM python:3.10-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Prevent Python from writing .pyc files to disk
ENV PYTHONDONTWRITEBYTECODE 1

# Prevent Python output from being buffered (ensures real-time logging)
ENV PYTHONUNBUFFERED 1

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

```
### Command use in this tutorial
| Docker Command                                                                                                                | Description                                                       |
|-------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|
| "docker build . -t helloword_app"                                                                                             | To generate a docker image based on a Dockerfile                  |
| "docker run -d -p 8001:8000 --name django_container helloword_app"                                                            | To start a docker container based on a given image                |
| "docker images"                                                                                                               | To list all the docker images present in the Docker server        |
| "docker image inspect image-id"                                                                                               | To display detailed image information for a given image id        |
| "docker image rm image-id"                                                                                                    | To remove one or more images for a given image ids                |
| "docker image push docker.io/eazybytes/accounts:s4"                                                                           | To push an image or a repository to a registry                    |
| "docker image pull docker.io/eazybytes/accounts:s4"                                                                           | To pull an image or a repository from a registry                  |
| "docker ps"                                                                                                                   | To show all running containers                                    |
| "docker ps -a"                                                                                                                | To show all containers including running and stopped              |
| "docker container start container-id"                                                                                         | To start one or more stopped containers                           |
| "docker container pause container-id"                                                                                         | To pause all processes within one or more containers              |
| "docker container unpause container-id"                                                                                       | To unpause all processes within one or more containers            |
| "docker container stop container-id"                                                                                          | To stop one or more running containers                            |
| "docker container kill container-id"                                                                                          | To kill one or more running containers instantly                  |
| "docker container restart container-id"                                                                                       | To restart one or more containers                                 |
| "docker container inspect container-id"                                                                                       | To inspect all the details for a given container id               |
| "docker container logs container-id"                                                                                          | To fetch the logs of a given container id                         |
| "docker container logs -f container-id"                                                                                       | To follow log output of a given container id                      |
| "docker container rm container-id"                                                                                            | To remove one or more containers based on container ids           |
| "docker container prune"                                                                                                      | To remove all stopped containers                                  |
| "docker compose up"                                                                                                           | To create and start containers based on given docker compose file |
| "docker compose down"                                                                                                         | To stop and remove containers                                     |
| "docker compose start"                                                                                                        | To start containers based on given docker compose file            |
| "docker compose down"                                                                                                         | To stop the running containers                                    |
| "docker run -p 3306:3306 --name accountsdb -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=accountsdb -d mysql"                 | To create a MySQL DB container                                    |
| "docker run -p 6379:6379 --name eazyredis -d redis"                                                                           | To create a Redis Container                                       |
| "docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:22.0.3 start-dev" | To create Keycloak Container                                      |
## Support
The development of the tutorial is supported by iPAC Lab.
## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.


## License

[MIT](https://choosealicense.com/licenses/mit/)