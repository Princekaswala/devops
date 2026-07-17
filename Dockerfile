From nginx:stable-alpine3.24-slim
COPY . /var/www/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
