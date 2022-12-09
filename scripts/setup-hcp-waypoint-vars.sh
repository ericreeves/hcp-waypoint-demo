#!/bin/bash
waypoint config set -runner REGISTRY_USERNAME=${REGISTRY_USERNAME} && \
    waypoint config set -runner REGISTRY_PASSWORD=${REGISTRY_PASSWORD} && \
    waypoint config set -runner REGISTRY_IMAGENAME=${REGISTRY_IMAGENAME}

 waypoint config set -runner TF_VAR_region=${TF_VAR_region}
