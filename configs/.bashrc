export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

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

# Git branch bash completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
  # Add git completion to aliases
  __git_complete g __git_main
  # __git_complete gc _git_checkout
  # __git_complete gm __git_merge
  # __git_complete gp _git_pull
fi

#
# Aliases
#
alias g='git'
alias p='python'
alias pinst='pip install -e .'
alias ll='gls -lah --color=auto --group-directories-first'
alias l=ll

#
# Rbenv
#
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# COLOURS!
export TERM=xterm-256color

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[\[\e[35m\]${BRANCH}${STAT}\[\e[m\]]"
	else
		echo ""
	fi
}

remote_local_host () {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "\[\e[32m\]\u@\h\[\e[31m\](REMOTE)"
  else
    echo "\[\e[32m\]\u@\h"
  fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}



# NEW STUFF

# export PS1="\[\e[m\][\[\e[33m\]\t\[\e[m\]] \[\e[m\][$(remote_local_host)\[\e[m\]] [\[\e[34m\]\w\[\e[m\]] $(parse_git_branch)
# \[\e[37m\]$\[\e[m\] "
export PS1="\[\e[m\][\[\e[33m\]\t\[\e[m\]] \[\e[m\][$(remote_local_host)\[\e[m\]] [\[\e[34m\]\w\[\e[m\]]
\[\e[37m\]$\[\e[m\] "

alias f5='source ~/.bashrc'

# Autocomplete?
complete -o nospace -o filenames -F fuzzypath cd ls cat

function fuzzypath() {
    if [ -z $2 ]
    then
        COMPREPLY=( `ls -a` )
    else
        DIRPATH=`echo "$2" | gsed 's|[^/]*$||'`
        BASENAME=`echo "$2" | gsed 's|.*/||'`
        FILTER=`echo "$BASENAME" | gsed 's|.|\0.*|g'`
        COMPREPLY=( `ls -a $DIRPATH | grep -i "$FILTER" | gsed "s|^|$DIRPATH|g"` )
    fi
}
