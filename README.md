# blank-template

A generic Dev Container-based project template. Node.js and Claude Code come
pre-configured, so you can use this as the starting point for a new project.

## Prerequisites

- Docker (e.g. Docker Desktop)
- VS Code + the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
  or GitHub Codespaces
- Claude Code configuration on the host machine (`~/.claude`, `~/.claude.json`)
  (these are mounted into the container, so your login/settings carry over)

## Getting started from this template

When creating a new project from this template, first update the following:

1. **Update the values in `.devcontainer/.env`**
   - `COMPOSE_PROJECT_NAME`: change to a name unique to the project (used for the container name, etc.)
   - `APP_PORT_DEV`: change so it doesn't collide with other projects' ports (the host-side published port)
2. Update `name` in `.devcontainer/devcontainer.json` to match the project name, if needed
3. Add any required OS packages to `.devcontainer/Dockerfile`
4. Add real dependencies and scripts (build / lint / test, etc.) to `package.json`
   - Currently this is just a skeleton with no dependencies or scripts

## Starting the container

### VS Code

1. Open the repository in VS Code
2. Run `Dev Containers: Reopen in Container` from the command palette
3. On first startup, `.devcontainer/setup.sh` (`npm install`) runs automatically

### CLI

```bash
docker compose -f .devcontainer/docker-compose.yml up -d
```

Once started, container port `5173` is published to the host port specified by `APP_PORT_DEV`
(handled by docker compose; change `APP_PORT_DEV` per project to avoid collisions).

## Using Claude Code

This template's Dev Container includes the `claude-code` Dev Container Feature, so the `claude`
command is available right away inside the container. The `mounts` in `devcontainer.json` also
bind-mount the host's `~/.claude` and `~/.claude.json` into the container, so if you're already
logged in and configured on the host, the same authentication/settings just work inside the
container too.

Just run this in a terminal inside the container:

```bash
claude
```
