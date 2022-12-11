PROMPT='
$(kube_ps1)
%(?::%{$fg_bold[red]%}%? )%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

KUBE_PS1_PREFIX=
KUBE_PS1_SEPARATOR=' '
KUBE_PS1_DIVIDER=/
KUBE_PS1_SUFFIX=
