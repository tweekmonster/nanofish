_fishy_collapsed_wd() {
  echo $(pwd | perl -pe "
    BEGIN {
      binmode STDIN,  ':encoding(UTF-8)';
      binmode STDOUT, ':encoding(UTF-8)';
    }; s|^$HOME|~|g; s|/([^/])[^/]*(?=/)|/\$1|g
")
}

default_prompt="%F{blue}%(!.#.$)%f%f"
vi_prompt="%F{001}{257}"

_nanofish_prompt() {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo -n "%{${fg[blue]}%}[%{${reset_color}%}"
    echo -n "%F{001}${${VIRTUAL_ENV}:t}%{${reset_color}%}"
    echo -n "%{${fg[blue]}%}]%{${reset_color}%} "
  fi

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

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}[%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
