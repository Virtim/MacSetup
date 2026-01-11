# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

MacSetup is an automation repository for setting up a new Mac with all necessary software, configurations, and preferences. It uses shell scripts, Makefile targets, and Homebrew Bundle to orchestrate the setup process.

## Common Commands

### Initial Setup
```bash
# Complete setup from scratch (runs all setup scripts)
make all

# Basic macOS setup only (Xcode tools, OS updates)
make macos

# Install Homebrew packages/casks from Brewfile
make brew

# Install Android development tools
make android

# Configure git username and email interactively
make git

# Setup dotfiles (configure shell to use repo-managed configs)
make dotfiles
```

### Dotfiles Management
```bash
# Setup dotfiles (run once per machine)
make dotfiles

# After setup, edit configurations in the repository
# Changes apply to new shells immediately
# Reload current shell
source ~/.zshrc
```

The dotfiles system provides centralized shell configuration:
- All configuration lives in `dotfiles/` directory in this repository
- System `~/.zshrc` and `~/.bashrc` only source from the repo
- Modular structure: separate files for environment variables, aliases, functions
- `local.zsh`/`local.sh` files (git-ignored) for sensitive/private configuration
- See `dotfiles/README.md` for detailed documentation

### Weekly Update Workflow
```bash
# Create branch, update Brewfile, commit, push, create and merge PR
make weeklyupdate
```

This target automates the weekly dependency update process:
1. Checks out fresh `master` branch
2. Creates dated branch using format `TM-update-MMWWYY` (month, week, year)
3. Runs `brew bundle dump -f` to regenerate Brewfile with current packages
4. Commits changes with message "Weekly update MMWWYY"
5. Pushes branch and creates PR using `gh` CLI
6. Auto-merges PR using admin privileges

**Note:** The Makefile variable `MMWWYY=$(shell date +%m%U%Y)` generates the date format.

### Launchd Automation
The repository includes a launchd configuration (`com.tim.weeklyupdate.plist`) that automatically runs `make weeklyupdate` every Monday.

To install:
```bash
cp com.tim.weeklyupdate.plist $HOME/Library/LaunchAgents/
launchctl load $HOME/Library/LaunchAgents/com.tim.weeklyupdate.plist
```

To uninstall/update:
```bash
launchctl unload $HOME/Library/LaunchAgents/com.tim.weeklyupdate.plist
# Make changes, then reload:
launchctl load $HOME/Library/LaunchAgents/com.tim.weeklyupdate.plist
```

Logs are written to:
- Standard output: `~/Library/Logs/weeklyupdate.log`
- Standard error: `~/Library/Logs/weeklyupdate.err`

## Architecture

### Setup Scripts
The repository uses a modular shell script approach:

- **osx.sh** - macOS foundation setup
  - Runs `sudo softwareupdate -ia` for OS updates
  - Installs Xcode Command Line Tools via `xcode-select --install`
  - Requires admin password and keeps sudo alive during execution

- **brew.sh** - Homebrew and package installation
  - Installs Homebrew if not present
  - Runs `brew upgrade` to update existing packages
  - Executes `brew bundle install` to install from Brewfile
  - Cleans up with `brew cleanup`

- **android.sh** - Android development environment
  - Installs Java, Android Studio, and Android SDK via Homebrew casks
  - Legacy script (uses deprecated `brew cask` commands)

- **git.sh** - Interactive git configuration
  - Prompts for and sets global `user.name` and `user.email`
  - Displays current config before/after changes

- **dotfiles.sh** - Shell configuration setup
  - Backs up existing `~/.zshrc` and `~/.bashrc` to timestamped directory
  - Creates new system RC files that source from `dotfiles/` directory
  - Copies template files for local/sensitive configuration
  - One-time setup that centralizes all shell config in this repository

- **.macos** - Comprehensive macOS preferences/defaults
  - 1000+ line script applying system-wide configuration
  - Sets UI/UX preferences, Finder settings, Dock configuration, etc.
  - Based on https://mths.be/macos

### Brewfile Structure
The Brewfile is the central dependency manifest:
- Uses Homebrew Bundle format
- Includes taps, formulae, casks, VSCode extensions, and go packages
- Regenerated monthly via `brew bundle dump -f`
- Contains ~70 brew packages, ~20 casks, ~30 VSCode extensions

Key dependencies include: ansible, docker, terraform (via tfenv), PostgreSQL, Redis, Python tooling (poetry, pyenv, black), and various development tools.

### CI/CD
GitHub Actions workflow (`.github/workflows/check.yml`):
- Runs on all pushes and pull requests
- ShellCheck linting for all shell scripts
- Slack notifications via webhook

### Scripts Directory
Contains additional launchd plists for automated tasks:
- `scripts/syncmovies/com.tim.syncmovies.plist`
- `scripts/syncshows/com.tim.syncshows.plist`

### Dotfiles Structure
Centralized shell configuration system in `dotfiles/` directory with cross-platform support:

**Core files:**
- `zshrc` - Main ZSH configuration (entry point, loads common + platform-specific)
- `bashrc` - Main Bash configuration (entry point, loads common + platform-specific)

**Common files (cross-platform):**
- `common.sh` - Environment variables (PATH, AWS, Ansible, NVM, etc.)
- `common-aliases.sh` - Command aliases (git, terraform, docker, etc.)
- `common-functions.sh` - Custom shell functions

**Platform-specific files:**
- `macos.sh` - macOS-specific configuration (Homebrew, pbcopy, OBJC settings)
  - Only loaded when `uname` returns "Darwin"

**Company/Job-specific files (outside repo):**
- `~/.company/` - Directory for company-specific configurations
  - **Lives completely outside the MacSetup repository**
  - Prevents accidentally committing company info to public repo
  - All `.sh` files in this directory are automatically sourced
  - Example: `~/.company/company.sh` for company company configuration
  - Contains non-secret work config (AWS profiles, tool aliases, etc.)
  - Can be tracked in a separate private repository
  - Independent from MacSetup updates

**Local files (git-ignored):**
- `local.zsh` - Private/sensitive ZSH config
- `local.sh` - Private/sensitive Bash config
- `local.zsh.template` - Template for ZSH local configuration
- `local.sh.template` - Template for Bash local configuration

**Key Design:**
- System `~/.zshrc` contains only: `source /path/to/MacSetup/dotfiles/zshrc`
- System `~/.bashrc` contains only: `source /path/to/MacSetup/dotfiles/bashrc`
- All actual configuration lives in the repository
- No duplication: common config in `common.*` files, platform-specific in `macos.sh`, job-specific in company files
- Works on macOS, Linux, and other Unix-like systems
- Platform detection via `uname` automatically loads appropriate configs
- Updates to repository files apply immediately to new shell sessions

**Loading Order:**
1. Common configuration (`common.sh`, `common-aliases.sh`, `common-functions.sh`)
2. Platform-specific (`macos.sh` on macOS only)
3. Company-specific (all `.sh` files in `~/.company/` - automatically sourced)
4. Local overrides (`local.zsh` or `local.sh` - git-ignored)

**File Type Guidelines:**
- **Common files**: Universal settings (editor, Python, Docker, generic aliases)
- **Platform files**: OS-specific settings (Homebrew on macOS, apt on Linux)
- **Company files (outside repo)**: Non-secret work config in `~/.company/` directory (AWS profile names, tool aliases)
  - Lives outside MacSetup repo to prevent accidental commits
  - Auto-loaded: just drop a `.sh` file in `~/.company/` directory
  - Can be tracked in separate private repository
  - Independent from MacSetup updates/changes
- **Local files (NOT committed)**: Secrets (API keys, tokens, passwords, SSO credentials)

## Important Notes

- All shell scripts implement sudo keep-alive loops to maintain admin privileges during long operations
- The `make all` target executes scripts sequentially: `osx.sh` → `brew.sh` → `android.sh` → `.macos` → `dotfiles.sh`
- `android.sh` requires Homebrew to be installed first (dependency on `brew.sh`)
- The monthly update process uses GitHub CLI (`gh`) and requires authentication
- The `--admin` flag in `gh pr merge` suggests this requires GitHub admin privileges on the repository
- **Dotfiles Philosophy**: Never edit `~/.zshrc` or `~/.bashrc` directly - only edit files in `dotfiles/` directory. System RC files are just pointers to the repository.
- Sensitive configuration (API keys, tokens, passwords) must go in `local.zsh`/`local.sh` files, which are git-ignored
