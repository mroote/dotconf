local ret_status="%{$fg[blue]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}"
PROMPT='${ret_status}:%{$fg[cyan]%}%c %{$reset_color%}$(git_prompt_info)%# '

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}): "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}) "
