#!/bin/bash
set -e

find public -name .gitignore -delete
cd public
git init . && \
git add . && \
git commit -m 'Automated Build' && \
git push -f git@github.com:roidelapluie/roidelapluie.be-output.git master

rm -rf .git && \
find . -type d -print0 | xargs -0 -L 1 -P 10 ../deploy-dir.sh || true
find . -type f -print0 | xargs -0 -L 1 -P 10 ../deploy-file.sh

