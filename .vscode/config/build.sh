#!/bin/sh

sed -i "s/%%WD%%/$(pwd)/g" .vscode/launch.json

make
