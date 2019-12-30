#!/bin/bash
sed "s/repoName/$1/g" "s/appName/$2/g" "s/tagVersion/$3/g" deployment.yaml >latest-deployment.yaml
