#!/bin/sh
# macOS-Specific Configuration
# This file is managed in the MacSetup repository
# Only sourced on macOS systems

# Homebrew configuration
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="/opt/homebrew/bin:$PATH"
fi

# macOS-specific Ansible configuration
# Fixes playbook crashes: https://github.com/ansible/ansible/issues/32499
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# macOS-specific aliases
alias tfs='terraform show tf.plan -no-color | pbcopy'  # Uses pbcopy (macOS clipboard)
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
