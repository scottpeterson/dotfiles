# Changelog

Changes to the shell, terminal, and git setup on this machine, newest first. Each entry lists what changed, what you might notice because of it, and how to undo it.

Before a file in `$HOME` is edited, a copy goes to `~/.dotfiles_backup/<timestamp>/`. To undo a whole session, copy the files from that folder back to `~`. To see the exact lines that changed, run `git log -p -- <file>` in this repo.

When you change a tracked file, add an entry here in the same commit.

## 2026-10-24: Starship prompt, leftover cleanup, one zsh, no Finicky

Backup: `~/.dotfiles_backup/20261024-175850/` (`.zshrc`, `.aliases`, `.zshrc.bak.jarvis`, `.finicky.js`, `.sdkman/`, `.config/fish/`)

### Prompt: bullet-train replaced by Starship

- **Installed `starship` with Homebrew.** `.zshrc` sets `ZSH_THEME=""` and runs `eval "$(starship init zsh)"` after loading `.aliases`. The new `~/.config/starship.toml` copies bullet-train's layout and colors: time, error status, user@host, folder, git, and command duration, then `$` on the next line.
- **Why:** bullet-train took about 410 ms to draw each prompt inside a git repo (180 ms of that came from running `node --version` for the Node segment). Starship takes about 24 ms in a repo and 10 ms elsewhere. Shell startup went from about 0.13 s to 0.15 s, because `starship init` adds about 18 ms.
  - *You might notice:* the Node version segment is gone. The git segment shows `✹` modified, `✚` staged, `✭` untracked, `✖` deleted, `➜` renamed, `═` conflicted, `⚑` stashed, and `⇡`/`⇣` ahead/behind, but no `✔` for a clean tree. A red `✘` segment appears after a command fails, and a green `⚙` segment appears when background jobs are running.
  - *If arrows or the branch symbol show as boxes or `?`:* the terminal font is not a Nerd Font. iTerm2 and Ghostty both use MesloLGS Nerd Font.
  - *To check prompt speed:* run `starship timings` inside a repo.
  - *To go back:* set `ZSH_THEME="bullet-train"` in `.zshrc` and delete the `eval "$(starship init zsh)"` line. The theme file is still in `~/.oh-my-zsh/custom/themes/`.

### Leftovers removed

- **SDKMAN:** removed the `sdk` lazy-load block from `.zshrc` and deleted `~/.sdkman`. No SDKs were installed through it.
  - *You might notice:* `sdk` is no longer a command.
- **Fish:** deleted `~/.config/fish/`. Fish was not installed; the folder held only a uv hook.
- **Old backup:** deleted `~/.zshrc.bak.jarvis` (June 2026).
- **Aliases removed from `.aliases`:**
  - `dock`, `fig`: Docker is not installed.
  - `r`: launched Rider, which is not installed. With the alias gone, `r` is zsh's built-in command again, which **reruns your last command**.
  - `ifactive`: needed `pcregrep`, which is not installed.
  - `chromekill`: its process pattern no longer matched Chrome's renderer processes.
  - `bci`: used `brew cask install`, which Homebrew removed. Use `brew install --cask`.
  - `urlencode`: was Python 2 code; this Mac has no `python` command.
  - `mergepdf`: the Automator script it called is gone from macOS. Use `qpdf --empty --pages a.pdf b.pdf -- out.pdf`.
  - `afk`: the `CGSession` tool it called is gone from macOS. Use `pmset displaysleepnow`.

### One zsh

- **Uninstalled Homebrew's zsh (5.9.2)** and removed it from the Brewfile. iTerm2, Ghostty, `zsh` typed at the prompt, and `#!/usr/bin/env zsh` scripts all use macOS's `/bin/zsh` (5.9) now. Homebrew completions still load, because `brew shellenv` in `.zprofile` adds them to `fpath`.
- **Deleted the `~/.zcompdump-...-5.9.2` completion cache,** which only Homebrew's zsh used.
- **Removed the `chsh` step from `all_brew.bash`,** so a new Mac keeps `/bin/zsh` as its login shell.
  - *You might notice:* nothing, unless a script needed a zsh 5.9.2 feature. To get it back, run `brew install zsh`.

### Default browser

- **Uninstalled Finicky** (Homebrew cask), removed it from login items, and deleted `~/.finicky.js`. Its only setting sent every link to Safari.
- **Set Safari as the default browser** for `http` and `https`.
  - *You might notice:* links open in Safari directly. To route some links to another browser again, run `brew install --cask finicky` and restore `.finicky.js` from the backup folder.

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
