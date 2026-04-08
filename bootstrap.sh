#!/usr/bin/env bash

# Bootstrap script for a fresh Mac setup.
# Run this before anything else — it installs Xcode CLT (required for git/make),
# clones this repo, and runs make all.
#
# Usage (on a brand new Mac, in Terminal):
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Virtim/MacSetup/main/bootstrap.sh)"
#
# Or if you already have the repo cloned, just run: make all

set -e

REPO_URL="https://github.com/Virtim/MacSetup.git"
REPO_DIR="$HOME/dev/MacSetup"

echo "=========================================="
echo "MacSetup Bootstrap"
echo "=========================================="

# Step 1: Install Xcode Command Line Tools (required for git and make)
if xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools already installed. Skipping."
else
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "A dialog has appeared — click Install and wait for it to complete."
  echo "Press Enter here once the installation finishes."
  read -r
  if ! xcode-select -p &>/dev/null; then
    echo "ERROR: Xcode Command Line Tools installation not detected. Please install manually and re-run."
    exit 1
  fi
  echo "Xcode Command Line Tools installed."
fi

# Step 2: Clone the repo (skip if already in it)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/Makefile" ]; then
  echo "Already inside MacSetup repo at $SCRIPT_DIR. Using current directory."
  REPO_DIR="$SCRIPT_DIR"
elif [ -d "$REPO_DIR" ]; then
  echo "MacSetup repo already exists at $REPO_DIR."
else
  echo "Cloning MacSetup repo to $REPO_DIR..."
  mkdir -p "$(dirname "$REPO_DIR")"
  git clone "$REPO_URL" "$REPO_DIR"
fi

# Step 3: Run full setup
cd "$REPO_DIR"
echo ""
echo "Starting full Mac setup via 'make all'..."
echo ""
make all
