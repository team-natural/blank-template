#!/bin/bash
set -e

# Install project dependencies
npm install

# Install Context Mode (context compression MCP) into the container
npm install -g context-mode
