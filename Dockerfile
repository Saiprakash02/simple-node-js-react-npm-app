FROM node:23-alpine AS build
WORKDIR /usr/nodejsapp
COPY . .
RUN npm install && npm run build

FROM nginx:alpine
COPY --from=build /usr/nodejsapp/build /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]