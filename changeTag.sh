#!/bin/bash
sed "s/tagVersion/$1/g" deployment.yaml >latest-deployment.yaml