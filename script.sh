#!/usr/bin/env sh
sudo docker run --rm -i hadolint/hadolint < Dockerfile > hadolint_output.txt
cat hadolint_output.txt
