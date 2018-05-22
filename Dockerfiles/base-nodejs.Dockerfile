FROM orbits-base-image

ENV NODE_VERSION v10.1.0

RUN apt-get install -y wget
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
RUN export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && nvm install "$NODE_VERSION"
RUN echo nvm use "$NODE_VERSION" >> ~/.bashrc

CMD echo "Start nodejs here"