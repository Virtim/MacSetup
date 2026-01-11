# Dotfiles

Centralized shell configuration management for all platforms (macOS, Linux, etc.).

## Structure

```
dotfiles/
├── zshrc                      # Main ZSH configuration (sources all modules)
├── bashrc                     # Main Bash configuration (sources all modules)
├── common.sh                  # Common environment variables (cross-platform)
├── common-aliases.sh          # Common aliases (cross-platform)
├── common-functions.sh        # Common functions (cross-platform)
├── macos.sh                   # macOS-specific configuration
├── local.zsh.template         # Template for local/private ZSH config
├── local.sh.template          # Template for local/private Bash config
└── README.md                  # This file

~/.company/                    # Company configs (outside this repo)
├── README.md                  # Documentation
├── example.sh.template        # Template for new company configs
└── *.sh                       # Your company configs (company.sh, etc.)
```

## Philosophy

- **Single Source of Truth**: All configuration lives in this repository
- **Cross-Platform**: Common configuration works on macOS, Linux, and other Unix-like systems
- **No Duplication**: Shared configuration is in common files, platform-specific in dedicated files
- **Modular**: Configurations are split into logical files (common, platform-specific, local)
- **Secure**: Sensitive data goes in `local.zsh`/`local.sh` (git-ignored)
- **Simple**: System RC files only point to this repo, nothing else

## Installation

Run the setup script to configure your system:

```bash
./dotfiles.sh
```

This will:
1. Back up your existing `~/.zshrc` and `~/.bashrc`
2. Create new system RC files that source from this repository
3. Copy `local.*.template` files for your sensitive configuration

## Adding Sensitive Configuration

1. Create `dotfiles/local.zsh` (for ZSH) or `dotfiles/local.sh` (for Bash):
   ```bash
   cp dotfiles/local.zsh.template dotfiles/local.zsh
   ```

2. Add your sensitive environment variables, API keys, etc. to the local file:
   ```bash
   export MY_SECRET_KEY="secret123"
   export WORK_API_TOKEN="token456"
   ```

3. The local files are git-ignored and will never be committed

## Usage

After installation:

- Edit configurations in this repository (not in `~/.zshrc` or `~/.bashrc`)
- Changes take effect immediately in new shell sessions
- Reload current shell: `source ~/.zshrc` or `source ~/.bashrc`

## Updating

When you modify dotfiles in this repository:

1. Changes automatically apply to new shell sessions
2. For current sessions, reload: `source ~/.zshrc`
3. All your machines pulling this repo get the same config
4. Use git to track changes and roll back if needed

## File Purposes

- **zshrc/bashrc**: Main entry points, load all modules with platform detection
- **common.sh**: Cross-platform environment variables (PATH, AWS, Ansible, NVM, etc.)
- **common-aliases.sh**: Cross-platform command shortcuts (git, terraform, docker, etc.)
- **common-functions.sh**: Cross-platform custom shell functions
- **macos.sh**: macOS-specific configuration (Homebrew, pbcopy aliases, etc.)
- **local.{zsh,sh}**: Private shell-specific config (API keys, passwords, tokens)

## Company/Job-Specific Configuration

Company-specific configuration lives in **`~/.company/`** - completely outside this repository.

### Why Outside the Repo?

- **Security**: This is a public repo - company configs never touch it
- **Independence**: Company configs managed separately from personal dotfiles
- **Flexibility**: Easy to track in a separate private repo if desired
- **Simplicity**: Just drop a `.sh` file in `~/.company/`, and it's automatically loaded

### Setting Up Company Configs

1. The directory is automatically created on first setup, or create it manually:
   ```bash
   mkdir -p ~/.company
   ```

2. Copy the template:
   ```bash
   cp ~/.company/example.sh.template ~/.company/company.sh
   ```

3. Edit with your company-specific configuration:
   ```bash
   # ~/.company/company.sh
   export AWS_PROFILE=company
   export AWS_REGION=us-west-2
   alias tf='AWS_PROFILE=company terraform'
   alias awssso='aws sso login --profile company'
   ```

4. The file is automatically sourced in new shell sessions

### What Goes Where?

| Type | Location | Git Tracked? | Purpose |
|------|----------|--------------|---------|
| Common config | `dotfiles/common*.sh` | Yes (MacSetup repo) | Universal settings |
| Platform config | `dotfiles/macos.sh` | Yes (MacSetup repo) | OS-specific settings |
| Company config | `~/.company/*.sh` | **No** (outside repo) | Company settings (no secrets!) |
| Secrets | `dotfiles/local.{zsh,sh}` | **No** (git-ignored) | API keys, tokens, passwords |


### Backing Up Company Configs

Since `~/.company/` is outside this repo, consider:
1. **Track in a separate private git repository** (recommended)
2. Sync to encrypted cloud storage (1Password, iCloud)
3. Include in your backup strategy

See `~/.company/README.md` for more details and examples.
