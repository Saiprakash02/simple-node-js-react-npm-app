# FROM node
# WORKDIR /usr/nodejsapp
# COPY . .
# RUN npm install
# EXPOSE 80
# CMD ["npm", "start"]

FROM node:18.0-slim
COPY . .
RUN npm install
CMD [ "node", "index.js" ]
