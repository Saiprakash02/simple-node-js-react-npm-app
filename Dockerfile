FROM node:23-alpine
WORKDIR /opt
COPY . .
RUN npm install
EXPOSE 3000
CMD [ "npm", "start" ]