FROM nginx:latest
COPY ./nginx.conf /etc/nginx/sites-enabled/default.conf
COPY ./build/web/* /usr/share/nginx/html/