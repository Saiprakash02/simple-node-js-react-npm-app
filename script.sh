#!/usr/bin/env sh
docker run --rm -i hadolint/hadolint < Dockerfile > hadolint_output.txt
cat hadolint_output.txt
