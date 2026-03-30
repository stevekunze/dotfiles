#!/usr/bin/env bash
set -euo pipefail

# Check for pacman
if ! command -v pacman >/dev/null 2>&1; then
  printf '%s\n' "Error: pacman not found. This script requires pacman (Arch Linux / derivatives)." >&2
  exit 1
fi

# Check if ansible is installed
if pacman -Qs '^ansible$' >/dev/null 2>&1; then
  printf '%s\n' "Ansible is already installed."
else
  printf '%s\n' "Ansible not found. Installing with pacman..."
  sudo pacman -Syu --noconfirm ansible
  if pacman -Qs '^ansible$' >/dev/null 2>&1; then
    printf '%s\n' "Ansible successfully installed."
  else
    printf '%s\n' "Failed to install Ansible." >&2
    exit 1
  fi
fi

# Ensure ansible-galaxy is available
if ! command -v ansible-galaxy >/dev/null 2>&1; then
  printf '%s\n' "Error: ansible-galaxy command not found after installing Ansible." >&2
  exit 1
fi

COLLECTION="kewlfft.aur"

# Check installed collections (robust parsing)
if ansible-galaxy collection list --format yaml 2>/dev/null | grep -q "^  - name: ${COLLECTION}$"; then
  printf '%s\n' "Collection '${COLLECTION}' is already installed."
else
  printf '%s\n' "Installing collection '${COLLECTION}'..."
  ansible-galaxy collection install "${COLLECTION}"
fi

exit 0