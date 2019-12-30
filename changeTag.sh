#!/bin/bash
sed "s/repoName/$1/g" deployment.yaml >latest-deployment.yaml
sed "s/appName/$2/g" deployment.yaml >latest-deployment.yaml
sed "s/tagVersion/$3/g" deployment.yaml >latest-deployment.yaml