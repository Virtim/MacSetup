# MacSetup

![CI](https://github.com/Virtim/MacSetup/workflows/CI/badge.svg?branch=master)

Repository to quickly install all required software on new mac

See [CLAUDE.md](CLAUDE.md) for detailed architecture and development information.

## Usage

Setup everything from scratch:

```bash
make all
```

Basic macos setup. Command line tools and dotfile.

```bash
make macos
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