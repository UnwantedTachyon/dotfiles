## Blue-White one
## export PS1="\[$(tput bold)\]\[\033[38;5;21m\][\[$(tput sgr0)\]\[\033[38;5;15m\]\u\[$(tput sgr0)\]\[\033[38;5;45m\]@\[$(tput sgr0)\]\[\033[38;5;27m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;45m\]\W\[$(tput sgr0)\]\[\033[38;5;21m\]]\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

## Multi colored one
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\[$(tput sgr0)\] "

## tests
## export PS1="\[$(tput bold)\]\[\033[38;5;160m\][\[$(tput sgr0)\]\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;227m\]@\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;27m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;128m\]\W\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;160m\]]\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# function _update_ps1() {
    # PS1=$(powerline-shell $?)
# }
#
# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    # PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi

## Powerline
## source /usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

## powerline-daemon -q
## POWERLINE_BASH_CONTINUATION=1
## POWERLINE_BASH_SELECT=1
## . /usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh



##### cool cool #####

#!/bin/bash
##########################################################
#Please edit "User Configuration" section before using   #
##########################################################

#=========================================================
#Terminal Color Codes
#=========================================================
WHITE='\[\033[1;37m\]'
LIGHTGRAY='\[\033[0;37m\]'
GRAY='\[\033[1;30m\]'
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
LIGHTRED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LIGHTGREEN='\[\033[1;32m\]'
BROWN='\[\033[0;33m\]' #Orange
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
LIGHTBLUE='\[\033[1;34m\]'
PURPLE='\[\033[0;35m\]'
PINK='\[\033[1;35m\]' #Light Purple
CYAN='\[\033[0;36m\]'
LIGHTCYAN='\[\033[1;36m\]'
DEFAULT='\[\033[0m\]'

#=========================================================
# User Configuration
#=========================================================
# Colors
cLINES=$GRAY #Lines and Arrow
cBRACKETS=$GRAY # Brackets around each data item
cERROR=$LIGHTRED # Error block when previous command did not return 0
cTIME=$LIGHTGRAY # The current time
cMPX1=$YELLOW # Color for terminal multiplexer threshold 1
cMPX2=$RED # Color for terminal multiplexer threshold 2
cBGJ1=$YELLOW # Color for background job threshold 1
cBGJ2=$RED # Color for background job threshold 2
cSTJ1=$YELLOW # Color for background job threshold 1
cSTJ2=$RED # Color for  background job threshold 2
cSSH=$PINK # Color for brackets if session is an SSH session
cUSR=$LIGHTBLUE # Color of user
cUHS=$GRAY # Color of the user and hostname separator, probably '@'
cHST=$LIGHTGREEN # Color of hostname
cRWN=$RED # Color of root warning
cPWD=$BLUE # Color of current directory
cCMD=$DEFAULT # Color of the command you type

# Enable block
eNL=1  # Have a newline between previous command output and new prompt
eERR=1 # Previous command return status tracker
eMPX=1 # Terminal multiplexer tracker enabled
eSSH=1 # Track if session is SSH
eBGJ=1 # Track background jobs
eSTJ=1 # Track stopped jobs
eUSH=1 # Show user and host
ePWD=1 # Show current directory

# Block settins
MPXT1="0" # Terminal multiplexer threshold 1 value
MPXT2="2" # Terminal multiplexer threshold 2 value
BGJT1="0" # Background job threshold 1 value
BGJT2="2" # Background job threshold 2 value
STJT1="0" # Stopped job threshold 1 value
STJT2="2" # Stopped job threshold 2 value
UHS="@"

function promptcmd()
{
        PREVRET=$?
        #=========================================================
        #check if user is in ssh session
        #=========================================================
        if [[ $SSH_CLIENT ]] || [[ $SSH2_CLIENT ]]; then
                lSSH_FLAG=1
        else
                lSSH_FLAG=0
        fi

        #=========================================================
        # Insert a new line to clear space from previous command
        #=========================================================
        PS1="\n"

        #=========================================================
        # Beginning of first line (arrow wrap around and color setup)
        #=========================================================
        PS1="${PS1}${cLINES}\342\224\214\342\224\200"

        #=========================================================
        # First Dynamic Block - Previous Command Error
        #=========================================================
        if [ $PREVRET -ne 0 ] ; then
                PS1="${PS1}${cBRACKETS}[${cERROR}:(${cBRACKETS}]${cLINES}\342\224\200"
        fi

        #=========================================================
        # First static block - Current time
        #=========================================================
        # PS1="${PS1}${cBRACKETS}[${cTIME}\t${cBRACKETS}]${cLINES}\342\224\200"

        #=========================================================
        # Detached Screen Sessions
        #=========================================================
        hTMUX=0
        hSCREEN=0
        MPXC=0
        hash tmux --help 2>/dev/null || hTMUX=1
        hash screen --version 2>/dev/null || hSCREEN=1
        if [ $hTMUX -eq 0 ] && [ $hSCREEN -eq 0 ] ; then
                MPXC=$(echo "$(screen -ls | grep -c -i detach) + $(tmux ls 2>/dev/null | grep -c -i -v attach)" | bc)
        elif [ $hTMUX -eq 0 ] && [ $hSCREEN -eq 1 ] ; then
                MPXC=$(tmux ls 2>/dev/null | grep -c -i -v attach)
        elif [ $hTMUX -eq 1 ] && [ $hSCREEN -eq 0 ] ; then
                MPXC=$(screen -ls | grep -c -i detach)
        fi
        if [[ $MPXC -gt $MPXT2 ]] ; then
                PS1="${PS1}${cBRACKETS}[${cMPX2}\342\230\220:${MPXC}${cBRACKETS}]${cLINES}\342\224\200"
        elif [[ $MPXC -gt $MPXT1 ]] ; then
                PS1="${PS1}${cBRACKETS}[${cMPX1}\342\230\220:${MPXC}${cBRACKETS}]${cLINES}\342\224\200"
        fi

        #=========================================================
        # Backgrounded running jobs
        #=========================================================
        BGJC=$(jobs -r | wc -l )
        if [ $BGJC -gt $BGJT2 ] ; then
                PS1="${PS1}${cBRACKETS}[${cBGJ2}&:${BGJC}${cBRACKETS}]${cLINES}\342\224\200"
        elif [ $BGJC -gt $BGJT1 ] ; then
                PS1="${PS1}${cBRACKETS}[${cBGJ1}&:${BGJC}${cBRACKETS}]${cLINES}\342\224\200"
        fi

        #=========================================================
        # Stopped Jobs
        #=========================================================
        STJC=$(jobs -s | wc -l )
        if [ $STJC -gt $STJT2 ] ; then
                PS1="${PS1}${cBRACKETS}[${cSTJ2}\342\234\227:${STJC}${cBRACKETS}]${cLINES}\342\224\200"
        elif [ $STJC -gt $STJT1 ] ; then
                PS1="${PS1}${cBRACKETS}[${cSTJ1}\342\234\227:${STJC}${cBRACKETS}]${cLINES}\342\224\200"
        fi

        #=========================================================
        # Second Static block - User@host
        #=========================================================
        # set color for brackets if user is in ssh session
        if [ $lSSH_FLAG -eq 1 ] ; then
                sesClr="$cSSH"
        else
                sesClr="$cBRACKETS"
        fi
        # don't display user if root
        if [ $EUID -eq 0 ] ; then
                PS1="${PS1}${sesClr}[${cRWN}!"
        else
                PS1="${PS1}${sesClr}[${cUSR}\u${cUHS}${UHS}"
        fi
        PS1="${PS1}${cHST}\h${sesClr}]${cLINES}\342\224\200"

        #=========================================================
        # Third Static Block - Current Directory
        #=========================================================
        PS1="${PS1}[${cPWD}\w${cBRACKETS}]"

        #=========================================================
        # Second Line
        #=========================================================
        PS1="${PS1}\n${cLINES}\342\224\224\342\224\200\342\224\200> ${cCMD}"
}

function load_prompt () {
    # Get PIDs
    local parent_process=$(tr -d '\0' < /proc/$PPID/cmdline | cut -d \. -f 1)
    local my_process=$(tr -d '\0' < /proc/$$/cmdline | cut -d \. -f 1)

    if  [[ $parent_process == script* ]]; then
        PROMPT_COMMAND=""
        PS1="\t - \# - \u@\H { \w }\$ "
    elif [[ $parent_process == emacs* || $parent_process == xemacs* ]]; then
        PROMPT_COMMAND=""
        PS1="\u@\h { \w }\$ "
    else
        export DAY=$(date +%A)
        PROMPT_COMMAND=promptcmd
     fi
    export PS1 PROMPT_COMMAND
}

load_prompt





## nice
## PS1="\n\[\e[30;1m\]\[\016\]\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"
