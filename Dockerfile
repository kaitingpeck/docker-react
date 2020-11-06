FROM node:10.23.0-alpine3.10 as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .
RUN npm run build
 
FROM nginx 
EXPOSE 80
# copy over the static resources required to serve the web app in prod
COPY --from=builder /app/build /usr/share/nginx/html