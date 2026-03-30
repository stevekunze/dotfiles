#!/usr/bin/env bash
set -euo pipefail

# Check for pacman
if ! command -v pacman >/dev/null 2>&1; then
  echo "Error: pacman not found. This script requires pacman (Arch Linux / derivatives)." >&2
  exit 1
fi

# Check if ansible is installed
if pacman -Qs '^ansible$' >/dev/null 2>&1; then
  echo "Ansible is already installed."
  exit 0
fi

echo "Ansible not found. Installing with pacman..."

# Update package database and install ansible
sudo pacman -Syu --noconfirm ansible

# Verify installation
if pacman -Qs '^ansible$' >/dev/null 2>&1; then
  echo "Ansible successfully installed."
  exit 0
else
  echo "Failed to install Ansible." >&2
  exit 1
fi
