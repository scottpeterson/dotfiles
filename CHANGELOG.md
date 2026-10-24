# Changelog

Changes to the shell, terminal, and git setup on this machine, newest first. Each entry lists what changed, what you might notice because of it, and how to undo it.

Before a file in `$HOME` is edited, a copy goes to `~/.dotfiles_backup/<timestamp>/`. To undo a whole session, copy the files from that folder back to `~`. To see the exact lines that changed, run `git log -p -- <file>` in this repo.

When you change a tracked file, add an entry here in the same commit.

## 2026-10-24: Git diff, aliases, and PATH cleanup

Backup: `~/.dotfiles_backup/20261024-175049/` (`.gitconfig`, `.aliases`, `.profile`, `.zprofile`, `.zshrc`)

### Git

- **`git diff` no longer uses difftastic by default.** Removed `external = difft` from `[diff]` in `.gitconfig`. Plain `git diff`, `git show`, and `git log -p` now print standard patches, so `git diff | git apply`, `git diff > file.patch`, and the `permission-reset` alias work again.
  - *You might notice:* diffs look like classic `+`/`-` patches instead of side-by-side.
  - *To get difftastic:* run `git ddiff`, `git dlog`, or `git dshow`. Each one sets `diff.external=difft` for that command only.
- **Removed the Sourcetree `difftool` and `mergetool` entries.** Nothing pointed at them.
  - *You might notice:* `git difftool --tool=sourcetree` and `git mergetool --tool=sourcetree` report an unknown tool.

### Aliases (`.aliases`)

- **Removed `gp` (`git pull --ff-only`).** The oh-my-zsh git plugin's `gp` now applies, and it runs **`git push`**.
  - *You might notice:* typing `gp` pushes instead of pulling. Use `git pull` (your `.gitconfig` already sets `pull.ff = only`) or oh-my-zsh's `gl`.
- **`emptytrash` now only empties the Trash.** Removed `sudo rm -rfv /private/var/log/asl/*.asl` and the SQL command that wiped download quarantine history.
  - *You might notice:* old Apple system log files and download history stay on disk.
- **`do_all` no longer runs `emptytrash`.** It still runs `update`, `brewall`, `mu`, and `cleanup`.
  - *You might notice:* the Trash stays full after `do_all`. Run `emptytrash` on its own.

### Shell startup

- **Deleted `~/.profile`.** zsh never reads it. Its PATH additions (`~/bin`, `~/.local/bin`) already happen in `.zshrc`.
  - *You might notice:* a `bash` or `sh` login shell no longer has `~/bin` or `~/.local/bin` on PATH.
- **Removed `export PATH="$PATH:/usr/local/bin"` from `.zprofile`** (the "Added by Toolbox App" block). `.zshrc` already adds `/usr/local/bin`.
  - *You might notice:* nothing in zsh. If JetBrains Toolbox re-adds the line, you can delete it again.
- **Added `typeset -U PATH path` to `.zshrc`** above the PATH exports. zsh now keeps only the first copy of each PATH entry. Before this change, `/usr/local/bin`, `/opt/homebrew/bin`, and three others each appeared twice.
  - *You might notice:* `path` (the alias) prints a shorter list. Command lookup order stays the same, because the first copy is the one that wins.

### Repo

- Stopped tracking `.profile` in `dotfiles.list` and deleted it from the repo.

## 2026-10-24: Machine-specific settings moved to local files

Backup: `~/.dotfiles_backup/20261024-174724/` (`.zshrc`, `.gitconfig`)

- **New `~/.zshrc.local`**, sourced at the end of `.zshrc`. It holds the `GOOGLE_APPLICATION_CREDENTIALS` export and the `jarvis` `.env` auto-load hook, both moved out of `.zshrc`.
  - *You might notice:* if either stops working, check that `~/.zshrc.local` exists and that the last line of `.zshrc` sources it.
- **New `~/.gitconfig.local`**, included at the end of `.gitconfig`. It holds `user.email`, moved out of `.gitconfig`.
  - *You might notice:* if git asks who you are or commits show the wrong email, check `~/.gitconfig.local`. On a new machine, create it with `git config --file ~/.gitconfig.local user.email "you@example.com"`.
- The repo now ignores `*.local`, so these files stay off GitHub.

## 2026-10-24: Repo synced with this machine and sync script added

No changes in `$HOME` in this session. All changes are in the repo.

- Copied the current home versions of `.aliases`, `.gitconfig`, `.profile`, `.vimrc`, and `.zshrc` into the repo, and regenerated `Brewfile` from installed packages.
- Started tracking `.zprofile`, `.gitignore_global`, and `.config/ghostty/config`.
- Replaced `copy_dotfiles.bash`, `run_diffs.bash`, and `upload_local_dotfiles.bash` with `dotfiles.sh` (`status`, `diff`, `pull`, `install`), which reads its list of files from `dotfiles.list`. `install` backs up each file it replaces.
- Rewrote `all_brew.bash` for current Homebrew and fixed the `chsh` typo.
- Removed `.bash_profile`, `.bash_prompt`, and `.bashrc` from the repo. They were not present on this machine. They remain in git history before commit `f8cb79f`.
