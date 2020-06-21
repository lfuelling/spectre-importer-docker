#!/bin/bash

echo "Now in entrypoint.sh (v1.0) for the Firefly III Spectre importer."
echo "Please wait for the container to start..."

# make sure the correct directories exists (suggested by @chrif):
mkdir -p $HOMEPATH/storage/app/public
mkdir -p $HOMEPATH/storage/build
mkdir -p $HOMEPATH/storage/database
mkdir -p $HOMEPATH/storage/debugbar
mkdir -p $HOMEPATH/storage/export
mkdir -p $HOMEPATH/storage/downloads
mkdir -p $HOMEPATH/storage/jobs
mkdir -p $HOMEPATH/storage/keys
mkdir -p $HOMEPATH/storage/uploads
mkdir -p $HOMEPATH/storage/framework/cache/data
mkdir -p $HOMEPATH/storage/framework/sessions
mkdir -p $HOMEPATH/storage/framework/testing
mkdir -p $HOMEPATH/storage/framework/views/twig
mkdir -p $HOMEPATH/storage/framework/views/v1
mkdir -p $HOMEPATH/storage/framework/views/v2
mkdir -p $HOMEPATH/storage/logs
mkdir -p $HOMEPATH/storage/upload

echo "..."

# make sure we own the volumes:
chown -R www-data:www-data -R $HOMEPATH/storage
echo "..."
chmod -R 775 $HOMEPATH/storage
echo "..."

# remove any lingering files that may break upgrades:
rm -f $HOMEPATH/storage/logs/laravel.log
echo "..."

composer dump-autoload > /dev/null 2>&1
echo "..."
php artisan package:discover > /dev/null 2>&1
echo "..."
php artisan cache:clear > /dev/null 2>&1
echo "..."
php artisan config:cache > /dev/null 2>&1
echo "..."
chown -R www-data:www-data -R $HOMEPATH
echo "..."
if [ -z ${FIREFLY_III_TRUSTED_HOST+x} ]; then
  echo "..."
else
  openssl s_client -showcerts -connect "$FIREFLY_III_TRUSTED_HOST" </dev/null 2>/dev/null|openssl x509 -outform PEM > "/trusted.pem"
  echo "..."
  export FIREFLY_III_TRUSTED_CERT="/trusted.pem"
fi
echo "..."
php artisan spectre:version

if [ "$WEB_SERVER" == "false" ]; then
	echo "Will launch import using /import/spectre.json."
	php artisan spectre:import /import/spectre.json
else
	echo "Will now run Apache web server:"
	exec apache2-foreground
fi
