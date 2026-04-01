# MacSetup

![CI](https://github.com/Virtim/MacSetup/workflows/CI/badge.svg?branch=main)

Repository to quickly install all required software on new mac

See [CLAUDE.md](CLAUDE.md) for detailed architecture and development information.

## Fresh Mac Setup (start here)

On a brand new Mac, open Terminal and run this single command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Virtim/MacSetup/main/bootstrap.sh)"
```

This will:
1. Install Xcode Command Line Tools (required for `git` and `make`)
2. Clone this repo to `~/dev/MacSetup`
3. Run `make all` to set up everything

> If you already have the repo cloned, just `cd` into it and run `make all`.

## Individual Targets

Setup everything from scratch:

```bash
make all
```

Basic macOS setup only (OS updates + Xcode CLT):

```bash
make macos
```

Homebrew packages only:

```bash
make brew
```

Setup centralized dotfiles (shell configuration):

```bash
make dotfiles
```

This configures your system to use repository-managed shell configs. All future configuration changes should be made in the `dotfiles/` directory. See `dotfiles/README.md` for details.

## How To Use Launchd file

Put launchd file and load it into launchctl:

```bash
cp com.tim.weeklyupdate.plist $HOME/Library/LaunchAgents
launchctl load com.tim.weeklyupdate.plist
```