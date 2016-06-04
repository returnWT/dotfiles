export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

autoload colors && colors
autoload -Uz vcs_info
zmodload zsh/terminfo

#
# PROMPT
#
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats " %b"
zstyle ':vcs_info:git*' actionformats ' %b|%a'

precmd () {
	psvar=()

	vcs_info
	[[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
  [[ -n $vcs_info_msg_0_ ]] && psvar[2]="`git_dirty`"
}

remote_local_host () {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "%{$fg_bold[red]%}(REMOTE: %n@%m)"
  else
    echo "%{$fg[green]%}(%n@%m)"
  fi
}

git_dirty () {
  if [[ $(git diff --ignore-submodules --shortstat 2> /dev/null | tail -n1) != "" ]]; then
    echo '*'
  fi
}

git_info () {
  echo "Breh"
}

plsparse='$(git_info)'
PROMPT="%{$fg[white][%T]%} `remote_local_host`%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%}%{$fg[magenta]%}%1v%{$fg_bold[red]%}%2v %{$fg[blue]%}%% %{$reset_color%}"

#
# Preferred editor for local and remote sessions
#
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export EDITOR='vim'
  alias vi='vim'
else
  export EDITOR='nvim'
  alias vi='nvim'
fi

#
# Tab-completion
#
autoload -Uz compinit && compinit
zstyle ':completion:*' completer _expand _complete _ignored _approximate

unsetopt menu_complete
setopt auto_menu
setopt complete_in_word
setopt always_to_end
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'
#
# Key bindings
#
bindkey '^?' backward-delete-char # Enable Backspace (WTF ZSH)
if [[ "${terminfo[kdch1]}" != "" ]]; then
	bindkey "${terminfo[kdch1]}" delete-char # Enable forward-delete
else
	bindkey "^[[3~" delete-char
	bindkey "^[3;5~" delete-char
	bindkey "\e[3~" delete-char
fi

#
# Aliases
#
alias g='git'
alias p='python'
alias psetup='python setup.py'
alias ll='gls -lah --color=auto --group-directories-first'
alias l=ll
#alias http="Python -m 'SimpleHTTPServer'"

#
# Rbenv
#
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# COLOURS!
export TERM=xterm-256color

export WORKON_HOME=$HOME/envs
source /usr/local/bin/virtualenvwrapper.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
