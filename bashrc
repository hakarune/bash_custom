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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

## Extract All Files ##
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1;;
      *.tar.gz)   tar xzf $1;;
      *.bz2)      bunzip2 $1;;
      *.rar)      rar x $1;;
      *.gz)       gunzip $1  ;;
      *.tar)      tar xf $1  ;;
      *.tbz2)     tar xjf $1;;
      *.tgz)      tar xzf $1;;
      *.zip)      unzip $1;;
      *.Z)	  uncompress $1 ;;
      *) 	  echo "'$1' cannot be extracted via extract()" ;;
      esac
    else
      echo "'$1' is not a valid file"
  fi
 }

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

#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.


# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset


ALERT=${BWhite}${On_Red} # Bold White on red background

echo -e "${BCyan}This is BASH ${BRed}${BASH_VERSION%.*}${BCyan}\
    - DISPLAY on ${BRed}$DISPLAY${NC}\n"
date
echo -ne "Hello, $USER! Today is $(date).\n"
echo -ne "System Info:  ${BRed}$(uptime)${NC}\n\n"

# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
      CNX=${Green}        # Connected on remote machine, via ssh (good).
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
      CNX=${ALERT}        # Connected on remote machine, not via ssh (bad).
else
      CNX=${BCyan}        # Connected on local machine.
fi

# Test user type:
if [[ ${USER} == "root" ]]; then
 SU=${Red}           # User is root.
elif [[ ${USER} != $(logname) ]]; then
 SU=${BRed}          # User is not login user.
else
 SU=${BCyan}         # User is normal (well ... most of us are).
fi

NCPU=$(grep -c 'processor' /proc/cpuinfo)    # Number of CPUs
SLOAD=$(( 100*${NCPU} ))        # Small load
MLOAD=$(( 200*${NCPU} ))        # Medium load
XLOAD=$(( 400*${NCPU} ))        # Xlarge load

# Returns system load as percentage, i.e., '40' rather than '0.40)'.
function load()
{
        local SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')
            # System load of the current host.
                echo $((10#$SYSLOAD))       # Convert to decimal.
            }

# Returns a color indicating system load.
function load_color()
{
 local SYSLOAD=$(load)
 if [ ${SYSLOAD} -gt ${XLOAD} ]; then
  echo -en ${ALERT}
 elif [ ${SYSLOAD} -gt ${MLOAD} ]; then
  echo -en ${Red}
 elif [ ${SYSLOAD} -gt ${SLOAD} ]; then
  echo -en ${BRed}
 else
  echo -en ${Green}
 fi
}

# Returns a color according to free disk space in $PWD.
function disk_color()
{
if [ ! -w "${PWD}" ] ; then
 echo -en ${Red}
 # No 'write' privilege in the current directory.
elif [ -s "${PWD}" ] ; then
  local used=$(command df -P "$PWD" |
  awk 'END {print $5} {sub(/%/,"")}')
 if [ ${used} -gt 95 ]; then
  echo -en ${ALERT}           # Disk almost full (>95%).
 elif [ ${used} -gt 90 ]; then
  echo -en ${BRed}            # Free disk space almost gone.
 else
  echo -en ${Green}           # Free disk space is ok.
 fi
else
 echo -en ${Cyan}
  # Current directory is size '0' (like /proc, /sys etc).
fi
}


#aliases 
alias ls='ls -hF --color' # add colors for filetype recognition 
alias lx='ls -lXB' # sort by extension 
alias lk='ls -lSr' # sort by size 
alias la='ls -aAl' # show hidden files 
alias lr='ls -lR' # recursice ls 
alias lt='ls -ltr' # sort by date 
alias lm='ls -al |more' # pipe through 'more' 
#alias tree='tree -Cs' # nice alternative to 'ls'
alias ll='ls -l' # long listing 
alias l='ls -hF --color' # quick listing 
alias lsize='ls --sort=size -lhr' # list by size 
alias l?='cat /home/will/technical/tips/ls' 
alias lsd='ls -l | grep "^d"' #list only directories Command substiution 
alias ff='find / -name $1' 
alias df='df -h -x tmpfs -x usbfs' 
alias psg='ps -ef | grep $1' 
alias h='history | grep $1' 
alias rm='rm -i' 
alias cp='cp -i' 
alias mv='mv -i' 
alias which='type -all' 
alias ..='cd ..' 
alias path='echo -e ${PATH//:/\\n}' 
alias vi='vim' 
alias du='du -h --max-depth=1' 
alias dus='du | sort -h'
alias cls='clear'
alias cpr='cp -g'
alias clean='clear && sudo apt-get clean'
alias cleanup='clear && sudo apt-get --purge autoremove && sudo apt-get clean'
alias debs='clear && ls -l /var/cache/apt/archives && ls -l /var/cache/apt/archives/partial'
alias findit='clear && sudo find /* -mount -name'
alias myOS='clear && lsb_release -d -c'
#alias myhdd='clear && sudo sfdisk -uS -l /dev/sda'
alias mykernels="dpkg --list | awk '/linux-image/ {print \$2}' && cat Documents/Remove\ a\ Kernel"
alias update='clear && sudo apt-get update'
#alias updatedb='clear && sudo updatedb'
alias aremove='clear && sudo apt-get autoremove'
alias fclean='clear && sudo apt-get --purge autoremove && sudo apt-get clean && sudo apt-get autoclean && sudo updatedb' 
alias sL='clear && grep "^[^#]" /etc/apt/sources.list'
alias installed='dpkg --get-selections | grep install > ~/internal/junk'
alias svi='sudo vi'
alias upgrade='clear && echo "Upgrading..." && sudo apt-get upgrade'
alias speedtest='speedtest-cli --bytes'
alias speedtest2='speedtest-cli --bytes --server 1780 && speedtest-cli --bytes --server 10162'
alias dclean='sh /srv/dev-disk-by-label-External/Programs/renamer.sh'
alias down='sh /srv/dev-disk-by-label-External/Programs/down.sh'
alias updatepip="pip freeze --local | tee before_upgrade.txt | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U && pip list --outdated | grep -G '(Current.*)' | sed 's/ (Current.*//' | xargs -n 1 sudo pip install --upgrade"
alias pipupdate="pip-review --local --interactive"
alias myip='nslookup whoami.akamai.net'
alias myip2='curl ipinfo.io/ip'
alias ln='ln -i' 
alias now='date +"%T"' 
alias mount='mount |column -t' 
alias wget='wget -c' 

#Timestamps
alias stamp='date "+%Y%m%d%a%H%M"'
alias da='date "+%Y-%m-%d %A %T %Z"'

# handy short cuts #
alias h='history' 
alias j='jobs -l' 

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto' 
alias egrep='egrep --color=auto' 
alias fgrep='fgrep --color=auto' 

## pass options to free ## 
alias meminfo='free -m -l -t' 

## get top process eating memory alias psmem='ps auxf | sort -nr -k 4' 
alias psmem10='ps auxf | sort -nr -k 4 | head -10' 

## get top process eating cpu ## 
alias pscpu='ps auxf | sort -nr -k 3' 
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ## 
alias cpuinfo='lscpu' 

#Personal Help 
#alias a?='cat /home/will/.alias.help' 
#alias f?='cat /home/will/.function.help' 
alias dn='OPTIONS=$(\ls -F | grep /$); select s in $OPTIONS; do cd $PWD/$s; break;done' 
#alias help='OPTIONS=$(\ls ~/.tips -F);select s in $OPTIONS; do less ~/.tips/$s; break;done' 

#show most popular commands 
alias top-commands='history | awk "{print $2}" | awk "BEGIN {FS="|"} {print $1}" |sort|uniq -c | sort -rn | head -10' 

# search for a package 
alias search="apt-cache search" 

# empty trash 
alias trash="rm -fr ~/.Trash"
