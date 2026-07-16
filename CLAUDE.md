# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About this template

This repository is not a specific project — it's the **standard template** the team/organization
uses as the starting point when spinning up a new project. Individual projects are created by
copying/forking this repository.

## Starting the container

- VS Code: run `Dev Containers: Reopen in Container` from the command palette
- CLI: `docker compose -f .devcontainer/docker-compose.yml up -d`

## Port configuration

`.devcontainer/.env`'s `APP_PORT_DEV` forwards to port 5173 inside the container and defaults to
5173. The intended workflow is running multiple projects created from this template side by side,
so `APP_PORT_DEV` is expected to be changed per project to avoid port collisions — don't assume
5173 is fixed or safe to hardcode elsewhere.

## Current state / commands

`package.json` currently has no dependencies and no scripts (no build/lint/test commands exist
yet). Check `package.json` before assuming any `npm run <script>` exists. When a real application
is added on top of this template, build/lint/test scripts should be added there.
