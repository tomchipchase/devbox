FROM alpine:latest

ARG USERID
ARG DOCKERID
ARG USERNAME

# Docker
RUN apk add --no-cache docker
# Docker Compose
RUN apk add --no-cache python2 py-pip && pip install --upgrade docker-compose && apk del --no-cache py-pip
# Shell
RUN apk add --no-cache zsh
# Setup a user
RUN mkdir -p /home/$USERNAME

RUN adduser -S -u $USERID -s /bin/zsh -h /home/$USERNAME $USERNAME

WORKDIR /home/$USERNAME

# If there is a clash with an existing group, add the user to that group,
# otherwise create a new docker group with the correct id and add the user to
# that
RUN if getent group $DOCKERID; then addgroup $USERNAME $(getent group $DOCKERID | cut -d: -f1); else addgroup -g $DOCKERID docker && addgroup $USERNAME docker; fi

USER $USERNAME

COPY config/zsh /home/$USERNAME

CMD ["zsh"]
