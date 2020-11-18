setopt PROMPT_SUBST

autoload -U add-zsh-hook
autoload -Uz vcs_info

# template shortcuts:
#
# %~    - current directory with $HOME replaced with ~
# %m    - hostname
# %n    - username
# %B/%b - start/end bold
# %F/%f - start/end format

FMT_ACTION="(%F{003}%a%f)"
FMT_VCS_STATUS="%F{006} %b%u%c%f"

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr    "%f %F{001}●"
zstyle ':vcs_info:*' stagedstr      "%f %F{002}✚"
zstyle ':vcs_info:*' actionformats  " ${FMT_VCS_STATUS} ${FMT_ACTION}"
zstyle ':vcs_info:*' formats        " ${FMT_VCS_STATUS}"
zstyle ':vcs_info:*' nvcsformats    ""
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# Check for untracked files.
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain | grep --max-count=1 '^??' &> /dev/null; then
        hook_com[staged]+="%f %F{001}●"
    fi
}

# Executed before each prompt.
add-zsh-hook precmd vcs_info

PROMPT=$'%B[%n@%m%b %~${vcs_info_msg_0_}%B]%b%# '
