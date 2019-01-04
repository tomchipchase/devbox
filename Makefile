.PHONY: build run

build: Dockerfile
	docker build . -t dev

run:
	docker run -v ~/src:/development -v /var/run/docker.sock:/var/run/docker.sock -it dev

default: build
