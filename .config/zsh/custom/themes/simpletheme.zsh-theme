<<<<<<< HEAD
KUBE_PS1_KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
KUBE_PS1_KUBECONFIGMD5=
KUBE_PS1_CTX=
KUBE_PS1_NS=

_update_KUBE_PS1() {
    local md5="$(md5sum $KUBE_PS1_KUBECONFIG)"

    [[ "$md5" == "$KUBE_PS1_KUBECONFIGMD5" ]] && return

    KUBE_PS1_KUBECONFIGMD5="$md5"
    KUBE_PS1_CTX="$(kubectl config current-context)"
    KUBE_PS1_NS="$(kubectl config view --minify -o jsonpath='{..namespace}')"
}

precmd() {
    _update_KUBE_PS1
    local ctx="$KUBE_PS1_CTX"
    local ns="$KUBE_PS1_NS"
    local symbol='\u2388 '
    local sep='/'
    local bg='\e[45m'
    local reset='\e[0m'
   #local end=" $reset\e[35m\ue0b4" # 
   #local end=" $reset\e[35m\ue0bc" # 
    local end=" $reset\e[35m\ue0b0" # 

    echo "$bg$symbol$ctx$sep$ns$end$reset"
}

PROMPT='%(?::%{$fg_bold[red]%}%? )%{$fg_bold[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
