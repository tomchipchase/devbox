.PHONY: build run

user := $(shell whoami)
userid := $(shell id -u)
dockerid := $(shell getent group docker | cut -d: -f3)

build: Dockerfile
	docker build . -t dev --build-arg USERNAME=${user} --build-arg USERID=${userid} --build-arg DOCKERID=${dockerid}

run:
	docker run -v ~/.ssh:/home/$(user)/.ssh -v ~/src:/home/$(user)/src -v /var/run/docker.sock:/var/run/docker.sock --hostname devbox -it dev

default: build
