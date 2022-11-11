FROM debian:bullseye

ARG DEBIAN_FRONTEND=noninteractive

# install dependencies, useful packages and some tools
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends apt-utils
RUN apt -qq install -y batctl net-tools alfred git cmake libjansson-dev zlib1g-dev curl pkg-config avahi-autoipd iproute2 nano

# build alfred-json
RUN git clone https://github.com/ffnord/alfred-json.git
RUN mkdir -p alfred-json/build
WORKDIR alfred-json/build
RUN cmake ../
RUN make
RUN make install

# install nodejs
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
    && nvm install 16.16.0

# get back to /
WORKDIR /

# configure batman-adv
ADD start-batman-adv.docker.sh /start-batman-adv.docker.sh
RUN echo 'batman-adv' | tee --append /etc/modules

CMD ["bash", "/start-batman-adv.docker.sh"]