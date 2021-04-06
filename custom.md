# Customization

Running an image from Docker Hub is quick but most of the time there will be more local customization you need in your image - extra libraries or programs you want to run, or files you want to copy into the container.

The following example shows how to do that. The Docker project in the example is named [mitato](https://en.wikipedia.org/wiki/Mitato). Choose your own name for your project and replace that word wherever it shows up.

Docker images are managed with the Docker Desktop app or using the docker command line tool. There's also a plugin for VSCode which is probably the easiest way to manage images and containers used for development. Dockerfiles are small, Docker images are large.

# The mitato Dockerfile, annotated



# Building and running for the first time

# Doing normal things

Normal development cycles shouldn't care about Docker in particular. Just start up the container and then connect to it the same as if it were a remote computer.

# Basic terminology
The analogies used here are really weak so ignore them once you learn a better explanation.

## Dockerfile

A Dockerfile is a text file that defines the contents of a Docker image.

A Dockerfile is sort of analogous to a Makefile in that a Makefile has a bunch of rules to build an executable and a Dockerfile has a bunch of rules which define how to build the image.

To make a Docker image from a Dockerfile go to the directory with the Dockerfile and run a command like:

```bash
docker build -t mitato:latest . 
```

This can take a long time. It often downloads gigabytes of stuff to create the image. Once the image is created, running it is a lot faster than building it.

## Docker image

A Docker image is kind of like a compiled executable. Running the image makes a container similar to the way that running an executable binary (or .exe) makes a process.

```bash
docker build --pull --rm -f "Dockerfile" -t hexo:latest "."
```


```bash
docker run -d --name="mitato-instance" -v /spin/zoneminder/config:/config:rw -p 80:80 mitato:latest
```

## Docker container

The programs in a Docker container are only available when the container is running. It's common to connect to a Docker container by attaching a terminal, connecting via SSH, or using a web browser to access something running in the container.

# Connecting to a container

### Attach

Attaching to a container means attaching standard input, standard output, and standard error to your terminal. When the container is running use the VSCode Docker extension or run [docker attach](https://docs.docker.com/engine/reference/commandline/attach/).

```bash
docker run --name test -d -it mitato:latest
docker attach test
```

Use ctrl-D or type exit to quit.

### SSH

Connecting over SSH is conceptually the same as connecting to any remote host over SSH. So there has to be an SSH server running in the container and you'll need a username and password or key for authentication.

### Browser

Often a container has a web application of some kind in it. Running a Jupyter server in a container is a good example. After it starts the web application can be used from a web browser on the host machine. 
