#!/bin/sh

cd "$(dirname "${0}")";

create_link() {
  local src=${1} dst=${2}
  local currentSrc=$(readlink "${dst}")

  if [ "$currentSrc" == "$src" ]; then
    return
  fi

  ln -sf "${src}" "${dst}"
}

echo "Updating..."
git pull origin master

echo "Creating symlinks..."
for src in $(find git vim -depth 1); do
  create_link ".dotfiles/${src}" "${HOME}/.$(basename ${src})"
done

sublimePath="${HOME}/Library/Application Support/Sublime Text 3/Packages"
if [ -d "${sublimePath}" ]; then
  create_link "${HOME}/.dotfiles/sublime" "${sublimePath}/User"
fi

echo "Done"