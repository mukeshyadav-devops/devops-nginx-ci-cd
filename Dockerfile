FROM nginx:latest

COPY web-app/index.html /usr/share/nginx/html/index.html

EXPOSE 80
