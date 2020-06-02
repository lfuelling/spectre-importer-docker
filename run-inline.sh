#
# This script will kick off the Spectre importer on the command line, using Docker run.
# After it has run, the container will be stopped and removed automatically.
# To configure this script, change the variables below to your liking.

#
# Refer here to your personal Spectre import configuration file.
#
JSON_CONFIG=/home/james/spectre_example.json

#
# Create a personal access token in your Firefly III installation, under 'Profile'
#
PERSONAL_ACCESS_TOKEN=ey...

#
# This is the full path to your Firefly III installation:
#
FIREFLY_III_URI=http:/172.17.0....

#
# Spectre information. Get this from your profile over at Spectre.
#
SPECTRE_APP_ID=
SPECTRE_SECRET=

#
# There is no need to touch anything after this point, but if you're smart you're free to do so.
#
DIR=$PWD

docker run \
--rm \
-v $JSON_CONFIG:/import/spectre.json \
-e FIREFLY_III_ACCESS_TOKEN=$PERSONAL_ACCESS_TOKEN \
-e FIREFLY_III_URI=$FIREFLY_III_URI \
-e SPECTRE_APP_ID=$SPECTRE_APP_ID \
-e SPECTRE_SECRET=$SPECTRE_SECRET \
-e WEB_SERVER=false \
fireflyiii/spectre-importer:develop
