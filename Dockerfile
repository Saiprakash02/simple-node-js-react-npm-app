FROM node:lts-buster-slim
WORKDIR /usr/nodejsapp
COPY . .
RUN npm install
EXPOSE 80
CMD ["npm", "start"]
