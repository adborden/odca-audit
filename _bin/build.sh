#!/bin/bash

set -o errexit
set -o pipefail
set -x

mkdir -p _site/assets
cp -R node_modules/bootstrap-sass/assets/{fonts,images,javascripts} _site/assets/
cp -R node_modules/jquery/dist/jquery.min.js _site/assets/javascripts/

mkdir -p _site/assets/js
for entrypoint in src/*.js; do
  bundle_name=$(basename $entrypoint .js)
  browserify $entrypoint -o _site/assets/js/${bundle_name}.bundle.js
done

jekyll build
