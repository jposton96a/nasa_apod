FROM ubuntu:20.10 as builder
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

#Installing Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH "$PATH:/usr/local/flutter/bin"
RUN flutter channel dev
RUN flutter upgrade
RUN flutter doctor

WORKDIR /workspace
COPY . .
RUN flutter build web

FROM nginx:latest
COPY ./nginx.conf /etc/nginx/sites-enabled/default.conf
COPY --from=builder /workspace/build/web/ /usr/share/nginx/html/s