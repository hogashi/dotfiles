# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=4000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -AF'
alias l='ls -CF'
alias lt='ls -tF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#export LC_MESSAGES=ja_JP.UTF-8
#export LC_IDENTIFICATION=ja_JP.UTF-8
#export LC_COLLATE=ja_JP.UTF-8
#export LANG=ja_JP.UTF-8
#export LC_MEASUREMENT=ja_JP.UTF-8
#export LC_CTYPE=ja_JP.UTF-8
#export LC_TIME=ja_JP.UTF-8
#export LC_NAME=ja_JP.UTF-8

case $TERM in
linux) LANG=C ;;
*) LANG=en_US.UTF-8 ;;
esac

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias emacs="emacs -nw"
SSH_ASKPASS=''
PATH="$PATH:${HOME}/.opt/share/git-core/contrib/diff-highlight"
# use 256colors in tmux
alias tmux="tmux -2"
alias bc="bc -l"
# english-japanese dictionary
function ejdic() {
  if [[ ! -n "$1" ]]; then
    echo 'ejdic -- English-Japanese dictionary'
    echo 'Usage: ejdic EN-WORD [-c]'
    echo '  -c: --color-auto'
    return
  fi
  COLSET='--color=always'
  if [[ "$2" = "-c" ]]; then
    COLSET='--color=auto'
  fi
  egrep "^[^#]*$1" ${HOME}/.gene-utf8-sharped.txt -A 1 -wi $COLSET | less
}
# japanese-english dictionary
function jedic() {
  if [[ ! -n "$1" ]]; then
    echo 'jedic -- Japanese-English dictionary'
    echo 'Usage: jedic JP-WORD [-c]'
    echo '  -c: --color-auto'
    return
  fi
  COLSET='--color=always'
  if [[ "$2" = "-c" ]]; then
    COLSET='--color=auto'
  fi
  egrep "^#.*$1" ${HOME}/.gene-utf8-sharped.txt -B 1 -wi $COLSET | less
}
export -f ejdic
export -f jedic

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi
if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
  # opt-vars: 1 or null
  GIT_PS1_STATESEPARATOR=', '
  GIT_PS1_SHOWUPSTREAM="auto verbose" # show number of commits ahead/behind (+/-) upstream, '=' if the same
  GIT_PS1_SHOWUNTRACKEDFILES=1 # show '%' if untracked files exist
  GIT_PS1_SHOWSTASHSTATE=1 # show '$' if stashed
  GIT_PS1_SHOWDIRTYSTATE=1 # show '*'/'+' if unstaged/staged-uncommited changes exist
fi
#export PS1='\[\e[m\]\[\e[1;32m\][\u@\h:\[\e[1;33m\]\w\[\e[1;36m\]$(__git_ps1 " - %s ")\[\e[1;32m\]]\[\e[m\]\n\[\e[1;32m\]\$\[\e[m\] '
export PS1='\[\e[m\]\[\e[1;32m\][\u@\h:\[\e[1;33m\]\w\[\e[1;32m\]]\[\e[1;33m\](${PIPESTATUS[@]})\[\e[m\]\n\[\e[1;32m\]\$\[\e[m\] '
if [ -d ${HOME}/.opt/bin ]; then
  PATH="${HOME}/.opt/bin:${PATH}"
fi

export LESS='-i -M -R -W -FX'
if which lesspipe.sh > /dev/null; then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

# anyenv settings
[[ -d ~/.anyenv  ]] && \
  export PATH="${HOME}/.anyenv/bin:${PATH}" && \
    eval "$(anyenv init -)"

# nodenv settings
[[ -d ~/.nodenv  ]] && \
  export PATH="${HOME}/.nodenv/bin:${PATH}" && \
    eval "$(nodenv init -)"

alias ghc="stack ghc"
