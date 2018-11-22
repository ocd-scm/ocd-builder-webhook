#!/bin/bash
docker build . -t simonmassey/ocd-builder-webhook
docker push simonmassey/ocd-builder-webhook:latest
