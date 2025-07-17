shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000

export EDITOR=vim
PS1='\u \w$ '

# Fixes GPG's ability to ask for a passphrase when called through Git. Don't
# ask me why.
export GPG_TTY=$(tty)

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.krew/bin" ] ; then
    PATH="$HOME/.krew/bin:$PATH"
fi

if [ -d "$HOME/.pyenv/bin" ] ; then
    PATH="$HOME/.pyenv/bin:$PATH"
fi

if [ -d "/opt/go/bin" ] ; then
    PATH="/opt/go/bin:$PATH"
fi

if command -v nvim >/dev/null; then
    alias vim=nvim
    export EDITOR=nvim
fi

[ $(which direnv 2>/dev/null) ] && eval "$(direnv hook bash)"
[ $(which pyenv 2>/dev/null) ] && eval "$(pyenv init -)"
[ $(which pyenv 2>/dev/null) ] && eval "$(pyenv virtualenv-init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f "$HOME/.cargo/env" ]; then . "$HOME/.cargo/env"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi

[ $(which aws_completer 2>/dev/null) ] && complete -C aws_completer aws

if [ $(which kubectl 2>/dev/null) ]; then
    PS1='($(kubectl config current-context)) \u \w$ '
    source <(kubectl completion bash)
    alias k="kubectl"
    complete -o default -F __start_kubectl k
fi

[ $(which flux 2>/dev/null) ] && eval "$(flux completion bash)"
[ $(which kustomize 2>/dev/null) ] && eval "$(kustomize completion bash)"
[ $(which helm 2>/dev/null) ] && eval "$(helm completion bash)"

if [ -f "$HOME/.bashrc_local" ]; then . "$HOME/.bashrc_local"; fi
