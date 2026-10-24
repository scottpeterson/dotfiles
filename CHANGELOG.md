# Changelog

Changes to the shell, terminal, and git setup on this machine, newest first. Each entry lists what changed, what you might notice because of it, and how to undo it.

Before a file in `$HOME` is edited, a copy goes to `~/.dotfiles_backup/<timestamp>/`. To undo a whole session, copy the files from that folder back to `~`. To see the exact lines that changed, run `git log -p -- <file>` in this repo.

When you change a tracked file, add an entry here in the same commit.

## 2026-10-24: iOS 26.0 simulator runtime removed

- **Deleted the iOS 26.0 simulator runtime** (8.0 GB, no recorded use) and its 11 simulators, none of which had ever started. iOS 27.0 and 27.1 and their 14 simulators stay.
  - *To get iOS 26 back:* Xcode > **Settings** > **Components**, then download iOS 26.0.

## 2026-10-24: Clawdbot workspace trashed, HP Product Research off

- **Moved `~/clawd` to the Trash.** Clawdbot's agent files (44 KB), unchanged since 2026-01-06, with nothing running from them. Recoverable until you empty the Trash.
- **Turned off HP Product Research** (HP's usage-data collection). Unloaded it and renamed `~/Library/LaunchAgents/com.hp.productresearch.plist` to `.plist.disabled`. Printing and HP Device Monitor (`com.hp.devicemonitor`) keep running.
  - *To undo:* rename the file back without `.disabled`, then log out and back in.

## 2026-10-24: Telegram uninstalled

- **Moved Telegram to the Trash** (direct download, not App Store or Homebrew; used only for Clawdbot), along with its data: `~/Library/Group Containers/6N38VWS5BX.ru.keepcoder.Telegram` (232 MB local cache), `Containers/ru.keepcoder.Telegram.TelegramShare`, and its `Application Support`, `Caches`, `HTTPStorages`, and `Preferences` entries. Chats stay on Telegram's servers.
  - *To undo before you empty the Trash:* put the items back from the Trash. Afterward, reinstall from telegram.org and sign in.
  - Two empty sandbox folders remain in `~/Library/Application Scripts`; macOS manages them.

## 2026-10-24: Two PATH lines removed from .zshrc

Backup: `~/.dotfiles_backup/20261024-182308/.zshrc`

- **Removed `export PATH="/usr/local/opt/openjdk/bin:$PATH"`.** The folder doesn't exist (Intel Homebrew path). `java` runs Homebrew's OpenJDK through `/usr/bin/java`.
- **Removed `export PATH="/opt/homebrew/bin:$PATH"`.** `brew shellenv` in `.zprofile` already adds it.
- **New order:** `~/.bun/bin`, `~/.local/bin`, `~/bin`, `/usr/local/bin`, `/opt/homebrew/bin`, `/opt/homebrew/sbin`, then system folders. Of 1,708 command names on PATH, only `code` and `macupdater_client` now resolve to a different file (`/usr/local/bin` instead of `/opt/homebrew/bin`), and both copies link to the same app, so nothing behaves differently.
  - *If a command runs the wrong version:* run `which -a <command>` to see every match in PATH order. A file in `~/bin` or `/usr/local/bin` now wins over Homebrew's copy.

## 2026-10-24: Home-folder clutter deleted

No backup; none of these held settings.

- **Deleted** two `~/.claude.json.tmp.*` files (leftovers from unfinished Claude Code saves in September; `~/.claude.json` itself is untouched), `~/.pgAdmin4.startup.log` (2019), `~/.yarnrc` (an update-check timestamp only), the empty `~/.config/mpv`, and `~/.bash_history` (last written July 2024).
  - *You might notice:* old bash commands are gone from history. zsh history (`~/.zsh_history`) is untouched.

## 2026-10-24: Git aliases trimmed

Backup: `~/.dotfiles_backup/20261024-182057/.gitconfig`

- **Removed 72 git aliases from `.gitconfig`.** Shell history since 2019 showed none of them in use, and no script or Claude config called them. Kept: `ddiff`, `dlog`, `dshow` (difftastic on request) and `permission-reset`.
  - *You might notice:* `git <alias>` reports "is not a git command". To get one back, copy its line from the backup into the `[alias]` section.
  - *Removed:* `git` `l` `lr` `ll` `lb` `lx` `la` `lra` `lla` `lba` `lxa` `ribbon` `catchup` `catchupall` `showf` `filelog` `relnotes` `precommit` `s` `st` `g` `d` `dc` `dl` `wdiff` `ss` `sl` `sa` `sd` `stashes` `snapshot` `b` `bl` `cob` `branches` `a` `ap` `assume` `unassume` `assumed` `unstage` `discard` `uncommit` `amend` `nuke` `c` `ci` `ca` `ours` `theirs` `mt` `mnf` `tags` `t` `cl` `co` `pl` `ph` `rv` `remotes` `ch` `cp` `cherry` `fp` `r` `rc` `rs` `continue` `skip` `sdiff` `spush` `supdate`

## 2026-10-24: Unused packages, old JDKs, and browser plugins removed

Holding folder for the plugins: `/private/var/tmp/usr-local-removed-20261024-181442/Library/`

- **Uninstalled Homebrew formulas** `libimobiledevice`, `sqlcipher` (never run), `lazygit` (run once), and `speedtest-cli` (run twice), plus the libraries only they needed. Removed from the Brewfile.
- **Uninstalled the `hp-easy-start` cask** (one-time printer setup).
- **Deleted Corretto 18 and Zulu 19** from `~/Library/Java/JavaVirtualMachines` (640 MB). No project targets them; IDE projects use JBR 21. Kept: Homebrew `openjdk` (27), `openjdk@21`, and JBR 17.
- **Moved the Intel Java 8 browser plugin and Flash Player leftovers** to the holding folder: `JavaAppletPlugin.plugin`, `PepperFlashPlayer`, `flashplayer.xpt`, both System Settings panels, `/Library/Application Support/Oracle` and `Macromedia`, and the `com.oracle.java.Java-Updater` launch agent, which tried and failed to run an Intel updater at each login.
- **Python 3.14 is now installed on request.** `brew autoremove` removed it along with `speedtest-cli`, which broke `whisper` (pipx) and `~/projects/scripts/.venv`, both built on it. It was reinstalled with `brew install python@3.14`, so autoremove keeps it.
  - *If a Python tool fails with "bad interpreter":* its virtual environment points at a Homebrew Python that is gone. Check with `head -1 $(which <tool>)`, then reinstall that Python or run `pipx reinstall <package>`.
  - *Before running `brew autoremove`:* check for venvs that use the Pythons it lists.

## 2026-10-24: Rectangle removed (Rectangle Pro kept)

- **Uninstalled the `rectangle` cask** and removed it from the Brewfile. Rectangle Pro does the same job and is the one that runs at login. macOS had no record of Rectangle being opened.
  - *You might notice:* nothing. If a window shortcut stops working, set it in Rectangle Pro.

## 2026-10-24: Heroku credentials removed

No backup, on purpose: a backup would keep the credential on disk.

- **Deleted `~/.netrc`.** It held a plain-text Heroku login from 2018 for `api.heroku.com` and `git.heroku.com`, and nothing else. The Heroku CLI never ran on this Mac.
  - *Still to do on Heroku's site:* revoke the old token at dashboard.heroku.com, under **Account settings** > **API Key** > **Regenerate API Key**.
  - *You might notice:* `git push heroku` and `heroku login` ask for credentials again, if you ever install the CLI.

## 2026-10-24: /usr/local cleared of Intel-era leftovers

Holding folder (nothing deleted yet): `/private/var/tmp/usr-local-removed-20261024-181442/` (2.9 GB). Each item keeps its original path inside it, for example `.../usr/local/bin/heroku`.

- **Moved 160 items out of `/usr/local`** (2.9 GB down to 1 MB). This Mac has no Rosetta, so none of the Intel, 32-bit Intel, or PowerPC programs could run. Moved: the 2019 .NET SDK and its `/etc/paths.d/dotnet` and `dotnet-cli-tools` entries; the old Intel Homebrew (`/usr/local/Homebrew`, `etc`, `var`, `include`, `share`); Python 2.7 to 3.10 libraries; the Heroku CLI; Ruby gems for the system Ruby (`bundle`, `bundler`); npm 8 and the Angular CLI; the git 2.7.1 installer; Docker, VirtualBox, Vagrant, kubectl, VLC, FileBot, R, Tcl/Tk, TextWrangler, and texinfo tools; FUSE and NTFS libraries; Citrix helper apps; Intel OpenSSL; man pages.
- **Kept in `/usr/local/bin`:** `code`, `macupdater_client`, and the JetBrains Toolbox launchers `idea`, `studio`, `studio1`. Also kept: `/usr/local/remotedesktop` (Apple Remote Desktop).
  - *You might notice:* `heroku`, `bundle`, `ng`, `R`, `dotnet`, `info`, and `kubectl` report "command not found". None of them ran on this Mac before.
  - *If tab completion shows an error in a new shell:* run `rm ~/.zcompdump*` and open a new tab.
  - *To restore one item:* `sudo mv /private/var/tmp/usr-local-removed-20261024-181442/usr/local/bin/<name> /usr/local/bin/`
  - *To finish:* after a few days with no problems, run `sudo rm -rf /private/var/tmp/usr-local-removed-20261024-181442`. macOS may also clear `/private/var/tmp` on its own over time, so restore anything you want before then.

## 2026-10-24: Git attributes tracked

- **Added `.config/git/attributes` to `dotfiles.list`.** It holds `* merge=mergiraf`, which tells git to use the mergiraf merge driver defined in `.gitconfig` for every file. No change on this Mac; a new Mac now gets the driver turned on by `./dotfiles.sh install`.
  - *If a merge behaves unexpectedly:* mergiraf resolves conflicts by syntax. To turn it off for one repo, add `* merge=text` to that repo's `.git/info/attributes` (git's built-in merge). To turn it off everywhere, delete the line from `~/.config/git/attributes`.

## 2026-10-24: Global git ignore fixed

Backup: `~/.dotfiles_backup/20261024-180623/` (`.gitignore_global`, `.config/git/ignore`)

- **Moved `**/.claude/settings.local.json` from `~/.config/git/ignore` into `~/.gitignore_global`, and deleted `~/.config/git/ignore`.** Git reads `~/.config/git/ignore` only when `core.excludesfile` is unset. `.gitconfig` sets it to `~/.gitignore_global`, so the rule never applied, and Claude Code's local permission file got committed in six repos.
  - *You might notice:* `.claude/settings.local.json` no longer shows as untracked in `git status`. Repos that already committed it keep tracking it until you run `git rm --cached .claude/settings.local.json` in each one.
  - *Rule of thumb:* put global ignore patterns in `~/.gitignore_global` only.
- **Untracked every committed `.claude/settings.local.json`** (the files stay on disk, so Claude Code keeps its permissions): `scottpeterson.github.io`, `d3-bball-npi` (2 files), `leverage-matrix`, `obs-notes` (6 files), `EloApp` (on branch `kmp-migration`), and `notes`. Pushed everywhere. In `notes`, the local commit `36bec36` (Virginia Wesleyan to Batten) duplicated the remote's `f506798`, made a minute apart, so the rebase dropped it and pushed only the untracking commit (`1f38fe2`). The uncommitted CalTech to Caltech rename was reapplied to the renamed scripts (`wbb_*_sidearm.py`) and CSVs, and left uncommitted. Backups in `~/.dotfiles_backup/20261024-182634/` (the dropped commit and the uncommitted diff, as patches); the original work is also in `git stash list` in `notes`. The rebase replaced this Mac's ignored `.claude/settings.local.json` with the remote copy, so the two were combined (42 rules).

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
