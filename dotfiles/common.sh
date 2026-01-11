#!/bin/sh
# Common Environment Variables and Configuration
# This file is managed in the MacSetup repository
# Compatible with both Bash and ZSH on all platforms

# Preferred editor
export EDITOR='vim'

# Python configuration
alias python='python3'

# Ansible configuration
export ANSIBLE_STDOUT_CALLBACK=yaml

# AWS Configuration (general)
# Job-specific AWS profiles should be set in job-specific files (e.g., ~/.company/company.sh)
export AWS_CLI_AUTO_PROMPT=on-partial

# PATH configuration - user local bins (Poetry and other local bins)
export PATH="$HOME/.local/bin:$PATH"

# Compiler flags for zlib (common across Linux and macOS)
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

# Load NVM if installed (cross-platform)
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
