FROM mcr.microsoft.com/devcontainers/base:bullseye

# Add project-specific packages here as needed.
# The base image already includes: git, curl, wget, and other common tools.
# mkcert is NOT installed here — HTTPS certs are generated on the HOST
# machine (see .devcontainer/mkcert.sh) and mounted into the container.

# Install uv (required by Semble MCP) to a shared location
# accessible by both root (build time) and vscode (runtime)
ENV UV_INSTALL_DIR="/usr/local/bin"
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
