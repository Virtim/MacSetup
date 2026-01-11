#!/usr/bin/env bash

# Dotfiles Setup Script
# This script configures your system to use dotfiles from this repository

set -e  # Exit on error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/dotfiles" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "=========================================="
echo "MacSetup Dotfiles Installation"
echo "=========================================="
echo ""
echo "This script will:"
echo "  1. Backup existing ~/.zshrc and ~/.bashrc to $BACKUP_DIR"
echo "  2. Create new RC files that source from this repository"
echo "  3. Set up local config templates for sensitive data"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo "Created backup directory: $BACKUP_DIR"

# Backup and setup ZSH
if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up existing ~/.zshrc"
    cp "$HOME/.zshrc" "$BACKUP_DIR/zshrc"
fi

if [ -f "$HOME/.zprofile" ]; then
    echo "Backing up existing ~/.zprofile"
    cp "$HOME/.zprofile" "$BACKUP_DIR/zprofile"
fi

echo "Creating new ~/.zshrc"
cat > "$HOME/.zshrc" <<EOF
# This file sources the centralized dotfiles from MacSetup repository
# Edit configurations in: $DOTFILES_DIR
# DO NOT add configurations here - add them to the repository instead

if [ -f "$DOTFILES_DIR/zshrc" ]; then
    source "$DOTFILES_DIR/zshrc"
else
    echo "Warning: MacSetup dotfiles not found at $DOTFILES_DIR"
    echo "Please check your MacSetup repository location"
fi
EOF

# Backup and setup Bash
if [ -f "$HOME/.bashrc" ]; then
    echo "Backing up existing ~/.bashrc"
    cp "$HOME/.bashrc" "$BACKUP_DIR/bashrc"
fi

if [ -f "$HOME/.bash_profile" ]; then
    echo "Backing up existing ~/.bash_profile"
    cp "$HOME/.bash_profile" "$BACKUP_DIR/bash_profile"
fi

echo "Creating new ~/.bashrc"
cat > "$HOME/.bashrc" <<EOF
# This file sources the centralized dotfiles from MacSetup repository
# Edit configurations in: $DOTFILES_DIR
# DO NOT add configurations here - add them to the repository instead

if [ -f "$DOTFILES_DIR/bashrc" ]; then
    source "$DOTFILES_DIR/bashrc"
else
    echo "Warning: MacSetup dotfiles not found at $DOTFILES_DIR"
    echo "Please check your MacSetup repository location"
fi
EOF

# Create .bash_profile if it doesn't exist (sources .bashrc)
if [ ! -f "$HOME/.bash_profile" ]; then
    echo "Creating new ~/.bash_profile"
    cat > "$HOME/.bash_profile" <<EOF
# Source .bashrc for interactive shells
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
EOF
fi

if [ ! -f "$DOTFILES_DIR/local.sh" ]; then
    echo "Creating local.sh template (for sensitive Bash config)"
    cp "$DOTFILES_DIR/local.sh.template" "$DOTFILES_DIR/local.sh"
    echo "  → Edit $DOTFILES_DIR/local.sh to add your sensitive configuration"
fi

echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "Your original dotfiles have been backed up to:"
echo "  $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "  1. Add sensitive config to: $DOTFILES_DIR/local.sh"
echo "  2. Restart your shell or run: source ~/.zshrc"
echo "  3. All future config changes should be made in: $DOTFILES_DIR"
echo ""
echo "To customize your configuration:"
echo "  - Common Aliases:      $DOTFILES_DIR/common-aliases.sh"
echo "  - Common Environment:  $DOTFILES_DIR/common.sh"
echo "  - Common Functions:    $DOTFILES_DIR/common-functions.sh"
echo "  - macOS-specific:      $DOTFILES_DIR/macos.sh"
echo "  - Secrets (Bash):      $DOTFILES_DIR/local.sh [git-ignored]"
echo ""
