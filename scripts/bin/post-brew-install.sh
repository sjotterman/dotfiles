#! /usr/bin/env bash

# gh extensions
gh extension install dlvhdr/gh-prs
gh extension install mislav/gh-branch
gh extension install seachicken/gh-poi

# npm packages
npm i -g pyright
npm i -g tldr
npm i -g vim-language-server
npm i -g vscode-langservers-extracted


# cht.sh https://github.com/chubin/cheat.sh
PATH_DIR="$HOME/bin"  # or another directory on your $PATH
if test -f "$PATH_DIR/cht.sh"; then
    echo "cht.sh already installed"
  else
    echo "Installing cht.sh"
    mkdir -p "$PATH_DIR"
    curl https://cht.sh/:cht.sh > "$PATH_DIR/cht.sh"
    chmod +x "$PATH_DIR/cht.sh"
  fi

git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
