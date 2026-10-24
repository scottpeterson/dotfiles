# dotfiles

Shell, git, and terminal configuration for macOS, plus a Brewfile of installed packages.

## Files

`dotfiles.list` names every tracked file. Each path is relative to both the repo root and `$HOME`, so `.config/ghostty/config` maps to `~/.config/ghostty/config`. To track another file, add its path to the list and run `./dotfiles.sh pull`.

## Commands

| Command | What it does |
|---------|--------------|
| `./dotfiles.sh status` | Lists each tracked file as `same`, `differs`, or missing on one side. |
| `./dotfiles.sh diff` | Shows a unified diff from the repo copy to the home copy. |
| `./dotfiles.sh pull` | Copies the home files into the repo and regenerates `Brewfile` from installed packages. |
| `./dotfiles.sh install` | Copies the repo files into `$HOME`. Before it replaces a file, it saves the old copy to `~/.dotfiles_backup/<timestamp>/`. |

To save changes from this machine, run `./dotfiles.sh pull`, review `git diff`, then commit.

## New machine

```sh
git clone https://github.com/scottpeterson/dotfiles.git ~/projects/dotfiles
~/projects/dotfiles/all_brew.bash
```

`all_brew.bash` installs Homebrew if needed, installs the Brewfile, upgrades casks, runs `./dotfiles.sh install`, and sets Homebrew's zsh as the login shell.

The shell config expects oh-my-zsh with the `bullet-train` theme and the `zsh-autosuggestions` plugin. Install those before you open a new shell.

## Machine-specific settings

Settings that should stay off GitHub go in two untracked files on each machine:

- `~/.zshrc.local`: sourced at the end of `.zshrc`. Holds private paths and per-project hooks.
- `~/.gitconfig.local`: included at the end of `.gitconfig`. Holds `user.email`.

On a new machine, create `~/.gitconfig.local` with your email before you commit:

```sh
git config --file ~/.gitconfig.local user.email "you@example.com"
```
