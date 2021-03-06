.PHONY: build run

user := $(shell whoami)
userid := $(shell id -u)
dockerid := $(shell getent group docker | cut -d: -f3)
remotehost := ssh://dev.tomchipchase.co.uk

build: Dockerfile
	docker build . -t dev --build-arg USERNAME=${user} --build-arg USERID=${userid} --build-arg DOCKERID=${dockerid}

run:
	docker run -v ~/.ssh:/home/$(user)/.ssh -v ~/src:/home/$(user)/src -v /var/run/docker.sock:/var/run/docker.sock -v ${SSH_AUTH_SOCK}:/ssh-agent.sock -v ~/.rubies/:/home/$(user)/.rubies -v ~/.kube:/home/$(user)/.kube -e SSH_AUTH_SOCK=/ssh-agent.sock --hostname devbox -e NCURSES_NO_UTF8_ACS=1 -p 8080 -it dev

default: build
