#!/bin/sh
# Common Shell Aliases
# This file is managed in the MacSetup repository
# Compatible with both Bash and ZSH on all platforms

# History — show full date+time with every entry (overrides Oh My Zsh's date-only alias)
alias history='fc -l -t "%Y-%m-%d %H:%M:%S" 1'

# Git aliases
alias gr='cd $(git rev-parse --show-toplevel)'  # Go to git root

# Terraform aliases (generic)
# Job-specific terraform aliases should be in job-specific files (e.g., ~/.company/company.sh)
alias tfg='terraform graph | dot -Tpng > graph.png'
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan -out tf.plan'
alias tfg='terraform graph | dot -Tpng > graph.png'

# 1Password aliases
alias opsignin='eval $(op signin)'

# Docker aliases
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'

# ls — use eza if available (colors, icons, folders on top), fall back to plain ls
if command -v eza &>/dev/null; then
  alias ls='eza -lah --group-directories-first --icons --octal-permissions --no-permissions --total-size'
else
  alias ls='ls -lah'
fi
