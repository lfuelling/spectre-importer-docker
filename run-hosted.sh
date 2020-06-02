#
# This script will kick off the Spectre importer on the command line, using Docker run.
# It will launch a web server on port 8081 that you can approach and use to import data.

#
# Create a personal access token in your Firefly III installation, under 'Profile'
#
PERSONAL_ACCESS_TOKEN=ey...

#
# This is the full path to your Firefly III installation:
#
FIREFLY_III_URI=http:/172.17.0.3/

#
# Spectre information. Get this from your profile over at Spectre.
#
SPECTRE_APP_ID=
SPECTRE_SECRET=

#
# There is no need to touch anything after this point, but if you're smart you're free to do so.
#

docker run \
--rm \
-e FIREFLY_III_ACCESS_TOKEN=$PERSONAL_ACCESS_TOKEN \
-e FIREFLY_III_URI=$FIREFLY_III_URI \
-e SPECTRE_APP_ID=$SPECTRE_APP_ID \
-e SPECTRE_SECRET=$SPECTRE_SECRET \
-p 8082:80 \
fireflyiii/spectre-importer:develop
