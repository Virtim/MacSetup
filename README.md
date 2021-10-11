# MacSetup

![CI](https://github.com/Virtim/MacSetup/workflows/CI/badge.svg?branch=master)

Repository to quickly install all required software on new mac

## Usage

Setup everything from scratch:

```bash
make all
```

Basic macos setup. Command line tools and dotfile.

```bash
make macos
```

## How To Use Launchd file

Put launchd file and load it into launchctl:

```bash
cp com.tim.weeklyupdate.plist $HOME/Library/LaunchAgents
launchctl load com.tim.weeklyupdate.plist
```