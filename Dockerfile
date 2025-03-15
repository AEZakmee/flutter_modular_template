FROM debian:latest AS build-env

# Only non-sensitive build arguments
ARG FIREBASE_PROJECT
ARG WEB_APP_ID
ARG ENVIRONMENT

ARG FLUTTER_VERSION=3.29.1

# Set as environment variables so they're available to scripts
ENV FIREBASE_PROJECT=$FIREBASE_PROJECT
ENV WEB_APP_ID=$WEB_APP_ID
ENV ENVIRONMENT=$ENVIRONMENT

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    nodejs \
    npm \
    xz-utils \
    bash

# Install Firebase CLI and ensure it's working
RUN npm install -g firebase-tools && firebase --version

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter && \
    cd /usr/local/flutter && \
    git checkout $FLUTTER_VERSION

# Add Flutter, Dart, and pub-cache to PATH
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:/root/.pub-cache/bin:${PATH}"

# Run Flutter once to download dependencies
RUN flutter doctor -v

# Set up the app
ARG PROJECT_ROOT=/project
RUN mkdir -p $PROJECT_ROOT
COPY . $PROJECT_ROOT
WORKDIR $PROJECT_ROOT

RUN chmod +x run_flutter_clean run_build_runner_packages run_flutter_gen_l10n build_flutterfire_configure_web get_main_package setup_web_env.sh

RUN ./setup_web_env.sh $ENVIRONMENT

RUN ./run_flutter_clean
RUN ./run_build_runner_packages

RUN --mount=type=secret,id=firebase_token \
    ./build_flutterfire_configure_web $FIREBASE_PROJECT $WEB_APP_ID "$(cat /run/secrets/firebase_token)"

RUN ./run_flutter_gen_l10n

RUN cd app && flutter build web

FROM nginx:1.25.2-alpine

COPY --from=build-env /project/app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 