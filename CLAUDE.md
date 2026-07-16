# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About this template

This repository is not a specific project — it's the **standard template** the team/organization
uses as the starting point when spinning up a new project. Individual projects are created by
copying/forking this repository.

## Bootstrapping a new project from this template

When this repo is being adapted into a real project (as opposed to being edited as the template
itself), update these first:

1. `.devcontainer/.env`: set `COMPOSE_PROJECT_NAME` to a name unique to the project (used for the
   container name) and change `APP_PORT_DEV` so it doesn't collide with other projects' ports.
2. `name` in `.devcontainer/devcontainer.json`, if it should match the project name.
3. `.devcontainer/Dockerfile`: add any OS packages the project needs.
4. `package.json`: add real dependencies and scripts (build/lint/test/dev). It currently ships as
   an empty skeleton (`type: module`, no dependencies, no scripts).

## Starting the container

- VS Code: run `Dev Containers: Reopen in Container` from the command palette
- CLI: `docker compose -f .devcontainer/docker-compose.yml up -d`

On first startup, `.devcontainer/setup.sh` runs automatically as the `postCreateCommand`: it runs
`npm install` and installs the `context-mode` MCP server globally (inside the container).

## Container architecture

- `docker-compose.yml` mounts only this repository into the container at `/workspace`
  (`workspaceFolder` in `devcontainer.json` matches). Sibling projects on the host are deliberately
  NOT visible from inside the container — each project gets its own isolated container. The
  container itself just `sleep infinity`s; devcontainer tooling execs into it.
- `devcontainer.json` adds two Dev Container Features: Node.js (`lts`) and `claude-code`, so both
  `node`/`npm` and the `claude` CLI are available with no manual setup and nothing is installed on
  the host.
- The host's `~/.claude` and `~/.claude.json` are bind-mounted in, so Claude Code auth/settings
  from the host carry over into the container automatically. These must exist on the host before
  first startup — otherwise Docker creates empty directories at those paths on the host.
- `Dockerfile` is based on `mcr.microsoft.com/devcontainers/base:bookworm` and additionally
  installs `uv` (required by the Semble MCP server, which runs via `uvx`).

## Port configuration

Container port 5173 is published to the host port set by `APP_PORT_DEV` in `.devcontainer/.env`
(default 5173), via the `ports` mapping in `docker-compose.yml`. The intended workflow is running
multiple projects created from this template side by side, so `APP_PORT_DEV` is expected to be
changed per project to avoid port collisions — don't assume 5173 is fixed or safe to hardcode
elsewhere. Port publishing is handled entirely by docker compose; `devcontainer.json` deliberately
has no `forwardPorts` (it would pin the host port to 5173 and defeat `APP_PORT_DEV`).

## MCP servers

Configured in `.mcp.json` and enabled in `.claude/settings.json`:

- `context7` — remote HTTP server for up-to-date library/framework docs.
- `context-mode` — local context-compression server, installed globally (in-container) by
  `setup.sh` and invoked directly by command name.
- `semble` — local code search server, run via `uvx` (needs the `uv` install in the Dockerfile).

## Current state / commands

`package.json` currently has no dependencies and no scripts (no build/lint/test commands exist
yet). Check `package.json` before assuming any `npm run <script>` exists. When a real application
is added on top of this template, build/lint/test scripts should be added there.
