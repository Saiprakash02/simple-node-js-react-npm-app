FROM node:23-alpine AS build
WORKDIR /usr/nodejsapp
COPY . .
RUN npm install
EXPOSE 80
CMD ["npm", "start"]
