#!/usr/bin/env bash
set -Eeuo pipefail

tmux new-session -d -s 11ty "npx @11ty/eleventy --serve --port 1000"
