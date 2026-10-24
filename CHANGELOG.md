# Changelog

Changes to the shell, terminal, and git setup on this machine, newest first. Each entry lists what changed, what you might notice because of it, and how to undo it.

Before a file in `$HOME` is edited, a copy goes to `~/.dotfiles_backup/<timestamp>/`. To undo a whole session, copy the files from that folder back to `~`. To see the exact lines that changed, run `git log -p -- <file>` in this repo.

When you change a tracked file, add an entry here in the same commit.

## 2026-10-24: Homebrew cache and old Gradle and Kotlin/Native versions removed

- **Ran `brew cleanup --prune=all`:** freed 659 MB of old downloads from `~/Library/Caches/Homebrew`. Installed packages are unchanged.
- **Deleted old Gradle distributions** 7.4.0, 9.1, 9.3.1, 9.5.1, and 9.7.1 from `~/.gradle/wrapper/dists`, plus the version caches `~/.gradle/caches/8.13`, `9.3.1`, and `9.5.1` (3.6 GB). Kept 9.8.1 and the shared `modules-2` dependency cache. Every branch of EloApp and todoistFocus uses 9.8.1.
  - *If an older project builds:* its wrapper downloads its Gradle version on the first build.
- **Deleted Kotlin/Native compilers** 1.7.10, 1.8.0, 1.9.25, and 2.3.21 from `~/.konan` (3.5 GB). Kept 2.4.21, which every branch uses, and `~/.konan/dependencies`.
  - *If a build needs an older Kotlin/Native:* Gradle downloads it on the next build.
- **Not changed:** `~/Library/Application Support/MDRP` (used by `/Applications/MDRP.app`). It was moved to the Trash by mistake and put back within a minute, unchanged.

## 2026-10-24: Logitech G HUB driver extensions turned off

- **Turned off `com.logi.ghub.hidfilter` (G HUB HID driver) and `com.logi.ghub.audiooverride` (Blue Voice)** in System Settings > **General** > **Login Items & Extensions** > **Driver Extensions**. G HUB itself was already uninstalled, and no Logitech G device or Blue microphone is in use. macOS removes them at the next restart.
  - *If a Logitech mouse, keyboard, or Blue microphone stops working:* install G HUB from logitech.com, which installs both extensions again.

## 2026-10-24: Empty Google Keystone agents and Maven cache trashed

- **Moved `~/Library/LaunchAgents/com.google.keystone.agent.plist` and `com.google.keystone.xpcservice.plist` to the Trash.** Both were empty 181-byte files from 2023 that started nothing. Chrome updates keep running through `com.google.GoogleUpdater.wake`.
- **Moved `~/.m2` to the Trash** (193 MB Maven download cache, last written 2025-11-09). Maven isn't installed, and no project in `~/projects` uses `mavenLocal()`.
  - *If a Gradle or IntelliJ build reports a missing local Maven artifact:* the tool downloads it again on the next build with network access, or you can put `~/.m2` back from the Trash.

## 2026-10-24: Unused Playwright Chromium build deleted

- **Deleted `chromium-1187` and `chromium_headless_shell-1187`** from `~/Library/Caches/ms-playwright` (475 MB, downloaded 2026-02-09). No installed Playwright uses build 1187. Build 1243 stays for `~/Documents/notes/venv`.
  - *If a script reports "Executable doesn't exist" for Chromium:* run `playwright install chromium` from that project's venv.
  - `~/projects/d3-bball-npi/.venv` uses build 1248, which isn't downloaded. Run `playwright install chromium` there before running it locally.

## 2026-10-24: Google Docs, Sheets, and Slides shortcut apps trashed

- **Moved `Google Docs.app`, `Google Sheets.app`, and `Google Slides.app` to the Trash** (about 300 KB, installed 2022-06-07 by Google Drive, which is no longer installed). The web versions in a browser are unaffected.
  - *To undo before you empty the Trash:* put them back from the Trash. Afterward, installing Google Drive for desktop adds them again.
- **Kept after review:** Microsoft Word, Plex, 1Blocker, Soulver 3, Portal Beta, and Trimmy.

## 2026-10-24: Old-Mac leftovers moved out of /Library

Moved 34 items (1.4 GB) to the holding folder `/private/var/tmp/usr-local-removed-20261024-181442`. Each keeps its original path inside it, so `/Library/Extensions/SoftRAID.kext` is now at `<holding folder>/Library/Extensions/SoftRAID.kext`.

- **File-system drivers** in `/Library/Filesystems`: `box.fs`, `fusefs.fs`, `kddfuse.fs`, `osxfuse.fs`, `ufsd_NTFS.fs` (Intel, 2022).
- **Kernel extensions** in `/Library/Extensions`: Canon `BJUSBLoad` and `CIJUSBLoad`; HP `hp_fax_io`, `hp_Inkjet3_io_enabler`, `hp_Inkjet8_io_enabler`, `hp_io_enabler_compound`; `jawbone`, `NikeSportWatch`, `JMicronATA`, `SiLabsUSBDriver`, `SoftRAID`, `Tether`, `Tether64`. None were loaded. The HP OfficeJet Pro 8720 prints and faxes over IPP (AirPrint), which doesn't use these.
- **Support folders** in `/Library/Application Support` for apps that aren't installed: `iDVD` (770 MB), `Logitech.localized` (252 MB), `iWork '09`, `iLifeSlideshow`, `Logic` (GarageBand content), `WDDesktop.app`, `Adobe` (Flash and Shockwave).
- **Helper tools** in `/Library/PrivilegedHelperTools`: Charles proxy (its LaunchDaemon was unloaded and moved too), Box Sync bootstrapper and icon helper, `com.docker.socket`, CleanMyMac 3 agent, Office 2011 licensing helper (the current `licensingV2` helper stays), and `Google Drive Icon Helper` (2013, ran as root).
- **Broken link** `/Library/LaunchDaemons/com.oracle.java.Helper-Tool.plist`, left by the Java plugin removal.
  - *If a printer, USB device, or app stops working:* move its item back with `sudo mv "<holding folder>/Library/..." "/Library/..."`, then restart.

## 2026-10-24: Developer caches and old Android SDK versions removed

- **Deleted the JetBrains Toolbox cache** (`~/Library/Caches/JetBrains/Toolbox/download` and `backup`, 4.7 GB): IDE installers, plus the rollback copy of the Android Studio canary installed before 2026-10-12.
  - *If the current Android Studio canary breaks:* install an older build from Toolbox's version list or the Android Studio download archive. Toolbox can no longer roll back on its own.
- **Ran `uv cache prune`:** removed 37,578 unused entries (1.3 GB). Cache now 839 MB. The `d3-bball-npi` and `scripts` venvs still import their packages.
- **Deleted Android SDK build-tools 30.0.2, 30.0.3, 32.0.0, 33.0.0, 33.0.1, 34.0.0** and **platforms android-30 to android-34** (1.6 GB) from `~/Library/Android/sdk`. Kept: build-tools 35.0.0, 35.0.1, 36.0.0; platforms 35, 36, 37.0. Projects compile against SDK 36 and 37.
  - *Check so far:* a `todoistFocus` build got through Gradle configuration and found android-36, then stopped on an unrelated issue (its new dependencies need compileSdk 37). A full build has not been confirmed yet.
  - *If a build reports "Failed to find Build Tools revision X" or "Failed to find target android-N":* install that version from Android Studio > **Settings** > **Languages & Frameworks** > **Android SDK**.
- **Not changed:** Carbon Copy Cloner's task database (5.4 GB). It belongs to the active backup task; trim it from CCC > **Task History** if needed.

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
