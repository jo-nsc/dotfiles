#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/jo-nsc/dotfiles.git"
DOTDIR="$HOME/.dotfiles"

echo "[1/3] Fetching dotfiles..."
if [ -d "$DOTDIR/.git" ]; then
  git -C "$DOTDIR" pull --ff-only
else
  git clone --depth 1 "$REPO_URL" "$DOTDIR"
fi

echo "[2/3] Installing vimrc..."
ln -sf "$DOTDIR/vimrc" "$HOME/.vimrc"

echo "[3/3] Installing vim-plug (if missing)..."
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Done. Open Vim and run :PlugInstall once."
