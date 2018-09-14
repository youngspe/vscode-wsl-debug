#!/bin/bash
TEMPLATE=$(cat .vscode/config/launchtemplate.json)
echo "${TEMPLATE//%%WD%%/$(pwd)}" > .vscode/launch.json

make
