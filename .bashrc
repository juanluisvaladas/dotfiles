#Autocomplete rhc
. /home/js/.openshift/bash_autocomplete

export GOPATH=$HOME/go

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
HISTSIZE=1000
HISTFILESIZE=2000

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

unset color_prompt force_color_prompt


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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

if [ $(id -u) -eq 0 ];then
       	# you are root, make the prompt red
    PS1='\[\e[1;31m\][\u@\h: $PWD]\n\$ \[\e[0m\]'
else
    PS1='\[\e[0;32m\][\u@\h: $PWD]\n\$ \[\e[0m\]'
fi

#My aliases
alias pa='ps aux | grep '
alias killsoma='ps aux | grep soma | sed -n "1p" | tr -s " " | cut -d " " -f 2 | xargs kill'
alias ..="cd .."
alias flusharp='while true; do sudo ip -s -s neigh flush all; sleep 5; done'
alias columnt='column -t'
alias print_label_vertical='lpr -o PageSize=30252_Address -o PrintQuality=Graphics -o PrintDensity=Light '
alias print_label_horizontal='lpr -o landscape -o PageSize=24_mm__1___Label__Auto_ docs/test.txt '
alias read_apm_log='cat /var/log/apm.log | egrep -v "^APM \[DEBUG\] \(collector.CollectorClient\) orkestra-[0-9]{1,3}-[0-9]{1,3}-[0-9]{1,3}-[0-9]{1,3}" | grep -v "^APM \[DEBUG\] (syncnova)" | egrep -v "^APM \[DEBUG\] \(bonjourhandler\) ([0-9]{1,3}[\. ]){4}" | egrep -v "APM \[DEBUG\] \(collector.Collector\) Refreshing at UTC 201[2-9]-([0-9]{2}[ -]){2}([0-9]{2}:?){3}$"'
alias repeat='until !!; do :; done'
alias fuck='sudo $(history -p \!\!)'
#Functions
ezextract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xjf $1		;;
			*.tar.gz)	tar xzf $1		;;
			*.bz2)		bunzip2 $1		;;
			*.rar)		rar x $1		;;
			*.gz)		gunzip $1		;;
			*.tar)		tar xf $1		;;
			*.tbz2)		tar xjf $1		;;
			*.tgz)		tar xzf $1		;;
			*.zip)		unzip $1		;;
			*.Z)		uncompress $1	;;
			*)			echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}


sshl (){
	ssh $1 -t '(wget http://10.0.2.17/~js/.bashrc -O tmpbash; bash --rcfile tmpbash; rm -f tmpbash; exit)'
}

killn () {
	ps aux | grep $1 | sed -n "1p" | tr -s " " | cut -d " " -f 2 | xargs kill
}

wiki (){
	dig +short txt ${1}.wp.dg.cx
}

esen () {
	string_to_replace="+"
	result_string="${1// /$string_to_replace}"
	wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$result_string&sl=es&tl=en"  | sed 's/\]\],/:/' | cut -d: -f2 | cut -d] -f1 | cut -d[ -f4 | sed 's/","/\n/g' | sed 's/"//'
}

enes () {
        string_to_replace="+"
        result_string="${1// /$string_to_replace}"
        wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$result_string&sl=en&tl=es"  | sed 's/\]\],/:/' | cut -d: -f2 | cut -d] -f1 | cut -d[ -f4 | sed 's/","/\n/g' | sed 's/"//'
}


pingts () {
	ping $1 | while read pong; do echo "$(date): $pong"; done
}

#Exports
export LESS='-R'
