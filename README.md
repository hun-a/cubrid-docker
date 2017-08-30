# What's this?
- Consists of Dockerfiles for CUBRID.

# Docker Hub
- [https://hub.docker.com/r/hunna/cubrid/](https://hub.docker.com/r/hunna/cubrid/)

# How to use
- clone this repository to your local.
```
$ git clone https://github.com/seunghun-kim/cubrid-docker.git
```

- build image from Dockerfile
```
$ sudo docker build -t cubrid .
```

- run the container from image
```
$ sudo run -v `pwd`:/opt/CUBRID/log/ -p 8001:8001 -p 30000:30000 -p 33000:33000 cubrid:latest
```
