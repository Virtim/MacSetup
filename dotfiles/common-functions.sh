#!/bin/sh
# Common Shell Functions
# This file is managed in the MacSetup repository
# Compatible with both Bash and ZSH on all platforms

# Add custom functions here
# Example:
mkcd() {
  mkdir -p "$1" && cd "$1" || return
}
