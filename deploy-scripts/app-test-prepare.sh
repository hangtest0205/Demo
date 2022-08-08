#!/bin/bash -e

# change to project root
cd ${0%/*}"/.."

echo "preparing test environment..."

rm -rf build
mkdir -p build

#Exit immediately if anything returns a non-zero status
set -e

# Copy project
rsync -avmq --stats --delete --exclude-from=deploy-scripts/.rsync-exclude ./* build

cp auth.json.sample build/auth.json
AUTH_FILE="build/auth.json"

[ ! -z "${COMPOSER_PUBLIC_KEY}" ] && sed -i "s/<public-key>/${COMPOSER_PUBLIC_KEY}/g" $AUTH_FILE
[ ! -z "${COMPOSER_PRIVATE_KEY}" ] && sed -i "s/<private-key>/${COMPOSER_PRIVATE_KEY}/g" $AUTH_FILE

cat build/auth.json

#Build
cd build

composer install
