FROM node:23.6.1-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx 

EXPOSE 80
# Normally "EXPOSE" instruction is communication to developers,
# but in the case of AWS deployment, EB looks for EXPOSE in Dockerfile
# and maps the port it automatically
COPY --from=builder /app/build /usr/share/nginx/html
