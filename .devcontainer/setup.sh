#!/bin/bash
set -e

# Install project dependencies
npm install

# Install Context Mode (context compression MCP)
npm install -g context-mode

# Approve pending install scripts for context-mode and its dependency better-sqlite3
npm approve-scripts --allow-scripts-pending
