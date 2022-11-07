FROM --platform=linux/amd64 node:alpine as build
WORKDIR /app
COPY package.json package.json
COPY jest.config.json jest.config.json
RUN npm install
COPY . . 

FROM build as test
RUN npm test

FROM test as deploy
CMD [ "npm", "start" ]
