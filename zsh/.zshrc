# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~
setopt extended_glob null_glob
# inside .zshrc
path=(
    $path                           # Keep existing PATH entries
    $HOME/bin
    $HOME/.local/bin
    $SCRIPTS
    /usr/local/bin
    /opt/homebrew/bin
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH


# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~


# Using GPG + YubiKey for ssh.


# export GPG_TTY="$(tty)"
# export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#
# gpgconf --launch gpg-agent
# gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1


# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~


# Set to superior editing mode

export VISUAL=nvim
export EDITOR=nvim
export TERM="tmux-256color"

export BROWSER="firefox"

# Directories

export REPOS="$HOME/Repos"
export GITUSER="mischavandenburg"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export ICLOUD="$HOME/icloud"
export ZETTELKASTEN="$HOME/Zettelkasten"

# Go related. In general all executables and scripts go in .local/bin

export GOBIN="$HOME/.local/bin"
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
# export GOPATH="$HOME/.local/share/go"
export GOPATH="$HOME/go/"


# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~


HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions


# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~


PURE_GIT_PULL=0


if [[ "$OSTYPE" == darwin* ]]; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
else
  fpath+=($HOME/.zsh/pure)
fi

autoload -U promptinit; promptinit
prompt pure


# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~


alias v=nvim
alias vim=nvim

alias scripts='cd $SCRIPTS'
alias cdblog="cd ~/websites/blog"
alias c="clear"

# Repos
alias lab='cd $LAB'
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'
alias ghrepos='cd $GHREPOS'
alias gr='ghrepos'
alias cdgo='cd $GHREPOS/go/'

# Homelab
alias homelab='cd $GHREPOS/homelab/'
alias hl='homelab'

# ls
alias ls='ls --color=auto'
alias la='ls -lathr'
# alias la='exa -laghm@ --all --icons --git --color=always'


# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias t='tmux'
alias e='exit'

# Git

alias gp='git pull'
alias gs='git status'
alias lg='lazygit'


# Zettelkasten

alias in="cd \$ZETTELKASTEN/0\ Inbox/"
alias cdzk="cd \$ZETTELKASTEN"


# Kubernetes

alias k='kubectl'

alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

alias fgk='flux get kustomizations'

# Pass

alias pc='pass show -c'

# cd
eval "$(zoxide init zsh)"
alias cd="z"

# cat 
alias cat="bat"

# ~~~~~~~~~~~~~~~ Sourcing ~~~~~~~~~~~~~~~~~~~~~~~~

source <(fzf --zsh)


# ~~~~~~~~~~~~~~~ Completion ~~~~~~~~~~~~~~~~~~~~~~~~
fpath+=~/.zfunc

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
zle-line-init() {}
bindkey '^l' autosuggest-accept
# Fix zsh autosuggestions keybind for arrow keys
bindkey '^k' history-beginning-search-backward
bindkey '^j' history-beginning-search-forward

# Example to install completion:
# talosctl completion zsh > ~/.zfunc/_talosctl

# ~~~~~~~~~~~~~~~ Misc ~~~~~~~~~~~~~~~~~~~~~~~~

alias lg="lazygit"
alias ep="vim ~/.zshrc"
alias rp="source ~/.zshrc"
alias ls="eza --git --git-repos -l -a --color=always --icons"

eval $(thefuck --alias fk)

cht() { curl cheat.sh/$1; }
alias ch=cht

