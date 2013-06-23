# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Enables timestamps in 'history' and .bash_history
export HISTTIMEFORMAT='%F %T '

# Store history immediately but ignore certain commands
PROMPT_COMMAND='history -a; history -n'
HISTIGNORE='bg:clear:exit:fg:history'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
unset HISTFILESIZE
set HISTSIZE = 1000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make a grep a little more useful
GREP_OPTIONS=
for PATTERN in .cvs .git .hg .svn; do
	GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$PATTERN --color"
done
export GREP_OPTIONS

# Tolerate typos when changing directories
shopt -s cdspell

# zsh-style cd string replacement
# If given two arguments to cd, replace the first with the second in $PWD,
function cd {
    while getopts lPe opt
    do
        local opts="$opts -$opt"
    done
    shift $(($OPTIND-1))
    if [[ -n "$2" ]]; then
        builtin cd $opts "${PWD/$1/$2}"
    elif [[ -n "$1" ]]; then
        builtin cd $opts "$1"
    else
        builtin cd $opts
    fi
}

# Bash bookmarking script
source ~/Downloads/Source/bashmarks/bashmarks.sh

# Shut up about mail
#unset MAILCHECK

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

# Adding jobs counter and turning on prompt variables
prompt_jobs() {
	    [[ -n "$(jobs)" ]] && printf '[%d]' $(jobs | sed -n '$=')
    }
shopt -s promptvars
if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' # Original
    #PS1='\n[\[\e[1;37m\]\u\[\e[0m\]@\[\e[1;34m\]\H\[\e[0m\]] [\[\e[1;33m\]\d, \t\[\e[0m\]] [\[\e[1;31m\]\!\[\e[0m\]]\n\[\e[1;31m\]\[\e[0m\][\[\e[1;37m\]\w\[ \e[0m\]]\n\[\e[1;37m\]\\$\[\e[0m\]' # Fancy time-stamps and who the hell knows what else
    PS1='${debian_chroot:+($debian_chroot)}\[\e[0;31m\][$?]\[\e[1;33m\]$(prompt_jobs)\[\033[0;35m\][\t]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# Enable 256-color mode

case "$TERM" in
	xterm*) TERM=xterm-256color
esac

# Colourful man pages
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode
export LESS_TERMCAP_md=$(printf '\e[01;38;5;75m') # enter double-bright mode
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;38;5;200m') # enter underline mode

# Disable flow-control
stty -ixon

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias bc='bc -l'
alias upgrade='sudo apt-get update ; sudo apt-get upgrade'
alias whatismyip='curl -s "http://checkip.dyndns.org" | sed "s/.*Current IP Address: \([0-9\.]*\).*/\1/g"'
alias randomfact='wget randomfunfacts.com -O - 2>/dev/null | grep \<strong\> | sed "s;^.*<i>\(.*\)</i>.*$;\1;"'
alias rhombus='kevedit /home/cory/.wine/drive_c/DOS/ZZT/RHOMBUS'
alias cmdstats='history | awk "{print $2}" | sort | uniq -c | sort -rn | head -10'
alias vcstimeFix='sudo ln -s /dev/vcsa /dev/vcsa0 && sudo ln -s /dev/vcs /dev/vcs0 && echo "vcstime ready for action"'
function vim-writer { vim -c 'set tw=72 et' '+/^$' --cmd 'set spell spelllang=en_gb' -c 'set formatoptions+=aw' "$@" ;}
function gvim-writer { gvim -c 'set tw=72 et' '+/^$' --cmd 'set spell spelllang=en_gb' -c 'set formatoptions+=aw' "$@" ;}
# Attach to existing tmux session rather than create a new one if possible.
function tmux {
    if [[ -n "$*" ]]; then
        command tmux $*
    else
        command tmux attach -d &>/dev/null || command tmux
    fi
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# SSH and GPG agent setup
export GPG_TTY=$(tty)
if [[ ! -n "$SUDO_USER" ]]; then
    eval $(keychain --eval --quiet id_rsa)
fi

# Run local file if it exists.
[[ -e "${HOME}/.bashrc.local" ]] && source "${HOME}/.bashrc.local"

echo
verse
echo
echo "Upcoming Events"
echo "---------------"
birthday
echo
calcurse -t
echo
