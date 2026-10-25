#!/usr/bin/env bash
# Sync the files in dotfiles.list between this repo and $HOME.
#
#   ./dotfiles.sh status    list which files differ, are missing, or match
#   ./dotfiles.sh diff      show a unified diff (repo -> home) for each file
#   ./dotfiles.sh pull      copy files from $HOME into the repo, plus the Brewfile
#   ./dotfiles.sh install   copy files from the repo into $HOME, backing up
#                           each file it replaces to ~/.dotfiles_backup/<timestamp>/
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
list_file="$repo_dir/dotfiles.list"

tracked_files() {
  grep -vE '^[[:space:]]*(#|$)' "$list_file"
}

cmd_status() {
  local f
  while IFS= read -r f; do
    if [[ ! -e "$HOME/$f" ]]; then
      echo "missing in home  $f"
    elif [[ ! -e "$repo_dir/$f" ]]; then
      echo "missing in repo  $f"
    elif cmp -s "$repo_dir/$f" "$HOME/$f"; then
      echo "same             $f"
    else
      echo "differs          $f"
    fi
  done < <(tracked_files)
}

cmd_diff() {
  local f
  while IFS= read -r f; do
    diff -u --label "repo/$f" --label "~/$f" \
      "$repo_dir/$f" "$HOME/$f" 2>/dev/null || true
  done < <(tracked_files)
}

cmd_pull() {
  local f
  while IFS= read -r f; do
    if [[ -e "$HOME/$f" ]]; then
      mkdir -p "$(dirname "$repo_dir/$f")"
      cp -p "$HOME/$f" "$repo_dir/$f"
      echo "pulled  $f"
    else
      echo "skipped $f (not in home)"
    fi
  done < <(tracked_files)

  if command -v brew >/dev/null 2>&1; then
    brew bundle dump --force --file="$repo_dir/Brewfile"
    # mas reports TestFlight builds as id 0, which brew bundle can't install.
    local testflight
    testflight=$(grep -E '^mas ".*", id: 0$' "$repo_dir/Brewfile" | cut -d'"' -f2 || true)
    if [[ -n "$testflight" ]]; then
      grep -vE '^mas ".*", id: 0$' "$repo_dir/Brewfile" > "$repo_dir/Brewfile.tmp"
      mv "$repo_dir/Brewfile.tmp" "$repo_dir/Brewfile"
      echo "dropped TestFlight apps from Brewfile (install them from TestFlight):"
      echo "$testflight" | sed 's/^/          /'
    fi
    echo "pulled  Brewfile"
  fi

  if [[ -n "$(git -C "$repo_dir" status --porcelain -- . ':!CHANGELOG.md')" ]] &&
     [[ -z "$(git -C "$repo_dir" status --porcelain -- CHANGELOG.md)" ]]; then
    echo "Tracked files changed. Add an entry to CHANGELOG.md before you commit."
  fi
}

cmd_install() {
  local f backup_dir backed_up=0
  backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"
  while IFS= read -r f; do
    [[ -e "$repo_dir/$f" ]] || { echo "skipped $f (not in repo)"; continue; }
    if [[ -e "$HOME/$f" ]]; then
      cmp -s "$repo_dir/$f" "$HOME/$f" && { echo "same    $f"; continue; }
      mkdir -p "$(dirname "$backup_dir/$f")"
      cp -p "$HOME/$f" "$backup_dir/$f"
      backed_up=1
    fi
    mkdir -p "$(dirname "$HOME/$f")"
    cp -p "$repo_dir/$f" "$HOME/$f"
    echo "installed $f"
  done < <(tracked_files)
  [[ $backed_up -eq 1 ]] && echo "Backups of replaced files: $backup_dir"
  return 0
}

case "${1:-status}" in
  status)  cmd_status ;;
  diff)    cmd_diff ;;
  pull)    cmd_pull ;;
  install) cmd_install ;;
  *) echo "usage: $0 {status|diff|pull|install}" >&2; exit 1 ;;
esac
