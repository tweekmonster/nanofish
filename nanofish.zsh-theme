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

_nanofish_role_color='green'; [ $UID -eq 0 ] && uc='red'
default_prompt="%F{blue}%(!.#.$)%f%f"
vi_prompt="%F{001}{257}"

_nanofish_end() {
  # echo "${${KEYMAP/vicmd/$vi_prompt}/(main|viins)/$default_prompt} "
  if [[ $KEYMAP == "vicmd" ]]; then
    echo -n "%{{cyan}"
  fi
  echo $default_prompt
}

_nanofish_prompt() {
  if [[ $UID == 0 ]]; then
    echo -n "%{${fg[red]}%}"
  else
    echo -n "%{${fg[green]}%}"
  fi

  echo -n "%n%{${reset_color}%}"
  echo -n "%{${fg[yellow]}%}@%{${reset_color}%}"
  echo -n "%F{184}%m%{${reset_color}%} "
  echo -n "%F{106}$(_fishy_collapsed_wd)%{${reset_color}%} "

  if [[ $KEYMAP == "vicmd" ]]; then
    echo -n "%{${fg[red]}%}"
  else
    echo -n "%{${fg[blue]}%}"
  fi

  echo -n '%(!.#.$) '
  echo -n "%{${reset_color}%}"
}

_nanofish_rprompt() {
  echo -n "$(git_prompt_info) "
  echo -n "%{${fg[green]}%}"
  echo -n '%D{%H:%M:%S}'
  echo -n "%{${reset_color}%}"
}

VIRTUAL_ENV_DISABLE_PROMPT=1
PS1='$(_nanofish_prompt)'
RPS1='$(_nanofish_rprompt)'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{blue}[%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue}]%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
