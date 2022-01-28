# docker-solarwinds-dpa

# Docker Build

```sh
docker build -t leflay/solarwinds-dpa:latest .
```
The command to login and push the image to docker hub repository is provided below.

# Docker Push 
```sh
docker login --username={username}
```
This will prompt you to enter the docker hub account password. On successfully logging in, you will be able to push the image to the repository 

```sh
docker push leflay/solarwinds-dpa --all-tags
```

# Docker Pull 
```sh
docker pull leflay/solarwinds-dpa[:latest]
```
 
Once the docker image is built or pulled from docker hub, Here is the docker run command to start the container. This will create DPA container and start the process. This will run the container in the daemon mode.

# Docker Run

```sh
docker run -d -p 8123:8123  -p 8124:8124 --name=dpainstance leflay/solarwinds-dpa:latest
```