#!/bin/sh

cd "$(dirname "${0}")";

echo "Updating..."
git pull origin master

echo "Creating symlinks..."
for src in $(find . -mindepth 2 -maxdepth 2 -not -path '*/\.*'); do
  ln -fs ".dotfiles/${src}" "${HOME}/.$(basename ${src})"
done

echo "Done"
