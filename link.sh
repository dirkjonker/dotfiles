#!/bin/bash

dotdir=$(readlink -f $0 | xargs dirname)

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}

# symlink all the non-existing directories
# in the XDG_CONFIG_HOME directory
for dir in ${dotdir}/xdg_config_home/*; do
  link_name="${XDG_CONFIG_HOME}/$(basename ${dir})"

  if [[ -L $link_name ]]; then
    echo "already a symlink: ${link_name}"
  else
    echo "linking ${dir} ${link_name}"
    ln -s ${dir} ${link_name}
  fi
done
