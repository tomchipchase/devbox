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

# Install configuration files
RUN apk add --no-cache stow

RUN apk add --no-cache vim git

USER $USERNAME

RUN git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/vundle
COPY config /home/$USERNAME/config
RUN cd config && stow *

# Configure vim
RUN vim +PluginInstall +qall

CMD ["zsh"]
