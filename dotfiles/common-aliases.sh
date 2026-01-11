#!/bin/sh
# Common Shell Aliases
# This file is managed in the MacSetup repository
# Compatible with both Bash and ZSH on all platforms

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
