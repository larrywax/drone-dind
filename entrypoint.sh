#!/bin/sh

set -e

dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 &

/bin/drone-agent
