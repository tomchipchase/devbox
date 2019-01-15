FROM alpine:latest

ARG USERID
ARG DOCKERID
ARG USERNAME

# Docker
RUN apk add --no-cache \
  curl \
  docker \
  dvtm \
  git \
  git-perl \
  openssh-client \
  stow \
  tig \
  vim \
  zsh

# Docker Compose
RUN curl -L --fail https://github.com/docker/compose/releases/download/1.23.2/run.sh -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# Setup a user
RUN mkdir -p /home/$USERNAME

RUN adduser -S -u $USERID -s /bin/zsh -h /home/$USERNAME $USERNAME

WORKDIR /home/$USERNAME

# If there is a clash with an existing group, add the user to that group,
# otherwise create a new docker group with the correct id and add the user to
# that
RUN if getent group $DOCKERID; then addgroup $USERNAME $(getent group $DOCKERID | cut -d: -f1); else addgroup -g $DOCKERID docker && addgroup $USERNAME docker; fi


USER $USERNAME

RUN git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/vundle
COPY config /home/$USERNAME/config
RUN cd config && stow *

# Configure vim
RUN vim +PluginInstall +qall

CMD ["ssh-agent", "dvtm"]
