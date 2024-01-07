FROM tensorflow/tensorflow:latest-jupyter as tensorflow

EXPOSE 8888
EXPOSE 9090


RUN apt update && apt install -y curl
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt update && apt install nodejs -y
RUN npm install --global yarn

WORKDIR /usr/src/application

COPY package*.json ./

RUN yarn install
