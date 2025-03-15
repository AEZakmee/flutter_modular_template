#!/bin/bash

ENVIRONMENT=$1

if [ "$ENVIRONMENT" != "dev" ] && [ "$ENVIRONMENT" != "prod" ]; then
    echo "Usage: $0 [dev|prod]"
    exit 1
fi

FLUTTER_ROOT_PACKAGE="$(./get_main_package)"
cd "$FLUTTER_ROOT_PACKAGE" || exit 1

cp -r "web_env/$ENVIRONMENT/"* web/

echo "Web environment set to $ENVIRONMENT" 