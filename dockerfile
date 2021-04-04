FROM ubuntu:20.10 as builder
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

#Installing Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH "$PATH:/usr/local/flutter/bin"
RUN flutter channel dev
RUN flutter upgrade
RUN flutter doctor

WORKDIR /workspace

# Dependencies
COPY pubspec.* ./
RUN flutter pub get

# Web source
COPY lib ./lib
COPY assets ./assets
COPY web ./web
# Define API key used to access NASA Astronomy Pic of the day
# Get one at: https://api.nasa.gov/
ARG API_KEY
RUN flutter build web --dart-define=NASA_API_KEY="${API_KEY}"

# Serve in nginx
FROM nginx:1.10-alpine
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /workspace/build/web/ /usr/share/nginx/html