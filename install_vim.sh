#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/jo-nsc/dotfiles.git"
DOTDIR="$HOME/.dotfiles"

echo "[1/4] Fetching dotfiles..."
if [ -d "$DOTDIR/.git" ]; then
  git -C "$DOTDIR" pull --ff-only
else
  git clone --depth 1 "$REPO_URL" "$DOTDIR"
fi

echo "[2/4] Installing vimrc..."
ln -sf "$DOTDIR/vimrc" "$HOME/.vimrc"

echo "[3/4] Installing vim-plug (if missing)..."
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "[4/4] Installing Vim plugins non-interactively..."
# --sync waits for install to finish before quitting
# +qa quits all windows afterward
vim +'silent! PlugInstall --sync' +qa

echo "All set. Vim is ready."
