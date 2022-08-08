#!/bin/bash -e

# change to project root
cd ${0%/*}"/.."

export AWS_PROFILE=${APP_NAME}-$CI_ENVIRONMENT_NAME

export DB_HOST=${1}
export DB_NAME=${2}
export DB_USER=${3}
export DB_PASSWORD=${4}

echo "starting build..."

rm -rf deploy/$CI_ENVIRONMENT_NAME
rm -rf build
mkdir -p build
mkdir -p build/magento
mkdir -p deploy/$CI_ENVIRONMENT_NAME

#Exit immediately if anything returns a non-zero status
set -e

# Copy project
rsync -avmq --stats --delete --exclude-from=deploy-scripts/.rsync-exclude ./* build/magento
rsync -avmq --stats --delete --exclude-from=deploy-scripts/.rsync-exclude ./deploy-scripts/* build/deploy-scripts
cp deploy-scripts/env.php build/magento/app/etc/env.php

CONFIG_FILE="build/magento/app/etc/env.php"

[ ! -z "${DB_HOST}" ] && sed -i "s/!HOST!/${DB_HOST}/" $CONFIG_FILE
[ ! -z "${DB_NAME}" ] && sed -i "s/!DBNAME!/${DB_NAME}/" $CONFIG_FILE
[ ! -z "${DB_USER}" ] && sed -i "s/!DBUSER!/${DB_USER}/" $CONFIG_FILE
[ ! -z "${DB_PASSWORD}" ] && sed -i "s/!DBPASS!/${DB_PASSWORD}/" $CONFIG_FILE

if [[ $CI_ENVIRONMENT_NAME == 'uat' ]]
then
	MAGEMODE="developer"
	[ ! -z "${MAGEMODE}" ] && sed -i "s/!MAGEMODE!/${MAGEMODE}/" $CONFIG_FILE
	[ ! -z "${UATREDISHOST}" ] && sed -i "s/!REDISHOST!/${UATREDISHOST}/" $CONFIG_FILE
else
	MAGEMODE="production"
	[ ! -z "${MAGEMODE}" ] && sed -i "s/!MAGEMODE!/${MAGEMODE}/" $CONFIG_FILE
	[ ! -z "${PRODREDISHOST}" ] && sed -i "s/!REDISHOST!/${PRODREDISHOST}/" $CONFIG_FILE
fi


cp auth.json.sample build/magento/auth.json
AUTH_FILE="build/magento/auth.json"

[ ! -z "${COMPOSER_PUBLIC_KEY}" ] && sed -i "s/<public-key>/${COMPOSER_PUBLIC_KEY}/g" $AUTH_FILE
[ ! -z "${COMPOSER_PRIVATE_KEY}" ] && sed -i "s/<private-key>/${COMPOSER_PRIVATE_KEY}/g" $AUTH_FILE

cat build/magento/auth.json

mv build/magento/appspec.yml build/appspec.yml

#Build
cd build/magento

composer install

cd ../

rm -rf magento/pub/media
rm -rf magento/pub/static/_cache

if [[ -z "${BUILDSTAMP}" ]]; then
    BUILDSTAMP=$(date +%Y%m%d-%H%M%S)
fi
tar -czf ../deploy/$CI_ENVIRONMENT_NAME/$APP_NAME-build-$BUILDSTAMP.tar.gz .

echo 'completed build'

#CURRENT_DIR=$(git rev-parse --show-toplevel)

#for f in $CURRENT_DIR/deploy/$CI_ENVIRONMENT_NAME/*-build-*.tar.gz ; do
#    filename="${f##*/}"
#    aws s3 cp $f s3://$APP_NAME-$AWS_REGION_NAME'-codedeploy-app-'$CI_ENVIRONMENT_NAME/$CI_ENVIRONMENT_NAME/$filename --region $AWS_REGION

#    dpl --provider=codedeploy --access-key-id=$AWS_ACCESS_KEY_ID --secret_access_key=$AWS_SECRET_ACCESS_KEY --application=$APP_NAME-$CI_ENVIRONMENT_NAME --deployment_group=$APP_NAME-$CI_ENVIRONMENT_NAME --revision_type=s3 --bucket=$APP_NAME-$AWS_REGION_NAME'-codedeploy-app-'$CI_ENVIRONMENT_NAME --bundle_type=tgz --key=$CI_ENVIRONMENT_NAME/$filename --region=$AWS_REGION --wait-until-deployed=true
#done
