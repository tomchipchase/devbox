FROM alpine:latest

ARG USERID
ARG DOCKERID
ARG USERNAME

# Docker
RUN apk add --no-cache \
  bash \
  build-base \
  curl \
  docker \
  dvtm \
  jq \
  gcc \
  git \
  git-perl \
  less \
  linux-headers \
  make \
  man \
  mysql-client \
  openssh-client \
  openssl-dev \
  sed \
  stow \
  tig \
  vim \
  zlib-dev \
  zsh

# Docker Compose
RUN curl -L --fail https://github.com/docker/compose/releases/download/1.24.1/run.sh -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# Ruby install
RUN curl -L --fail https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz -o /ruby-install-0.7.0.tar.gz && tar -xf ruby-install-0.7.0.tar.gz && cd /ruby-install-0.7.0 && make install && cd - && rm -r /ruby-install-0.7.0

# Chruby
RUN curl -L --fail https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz -o chruby-0.3.9.tar.gz && tar -xf /chruby-0.3.9.tar.gz && cd /chruby-0.3.9 && make install && cd - && rm -r /chruby-0.3.9

# Kubectl
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

# Stern
RUN curl -L https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 -o /usr/local/bin/stern && chmod +x /usr/local/bin/stern

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

CMD ["dvtm"]
