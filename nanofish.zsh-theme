_fishy_collapsed_wd() {
  echo $(pwd | perl -pe "
    BEGIN {
      binmode STDIN,  ':encoding(UTF-8)';
      binmode STDOUT, ':encoding(UTF-8)';
    }; s|^$HOME|~|g; s|/([^/])[^/]*(?=/)|/\$1|g
")
}

_virtualenv_prompt() {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "%F{blue}[%F{001}${${VIRTUAL_ENV}:t}%F{blue}]%f "
  fi
}

local uc='green'; [ $UID -eq 0 ] && uc='red'

VIRTUAL_ENV_DISABLE_PROMPT=1
PROMPT='$(_virtualenv_prompt)%F{$uc}%n%F{yellow}@%F{184}%m %F{green}$(_fishy_collapsed_wd)%F{blue} %(!.#.$)%f '
RPROMPT='$(git_prompt_info) %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{blue}[%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue}]%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
