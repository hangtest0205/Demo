#!/bin/bash

# We need to install dependencies only for Docker
[[ ! -e /.dockerenv ]] && exit 0

set -xe

mkdir ~/.aws/
touch ~/.aws/credentials

if [ $CI_ENVIRONMENT_NAME == 'uat' ]
then
	printf "[%s-%s]\naws_access_key_id = %s\naws_secret_access_key = %s\n" "$APP_NAME" "$CI_ENVIRONMENT_NAME" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" >> ~/.aws/credentials
else
	printf "[%s-%s]\naws_access_key_id = %s\naws_secret_access_key = %s\n" "$APP_NAME" "$CI_ENVIRONMENT_NAME" "$AWS_ACCESS_KEY_ID_PROD" "$AWS_SECRET_ACCESS_KEY_PROD" >> ~/.aws/credentials
fi
