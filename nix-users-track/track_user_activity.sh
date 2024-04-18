#! /bin/bash
# To add inside /etc/profile.d/ directory and you can protect it
# using "chattr +i /etc/profile.d/track_user_activity.sh"
# Change the name of this script to something more "USUAL" if you are a suspicious Admin :-
# The logs will reside inside /var/log/syslog
# I advise you to disable the password usage for SSH sessions
# by adding "PasswordAuthentication no" to the "/etc/ssh/sshd_config" file

export CLIENT_IP=$(who -m | sed -r "s/.*\((.*)\).*/\\1/")
export DATE=$(date "+%d/%m/%Y %H:%M:%S")
export REAL_USER=$(who -m | cut -f 1 -d " ")

export HISTTIMEFORMAT="[ %d/%m/%Y %H:%M:%S ] "
export HISTFILESIZE='5000'
export HISTSIZE='5000'
export HISTIGNORE=''
export HISTCONTROL='ignoredups'

shopt -s histappend
shopt -s histverify

export PROMPT_COMMAND='RETRN_VAL=$?;history -a;logger -p user.info -t tracking"[$$]" "[ $REAL_USER::$USER@$CLIENT_IP:$PWD ] $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//") [$RETRN_VAL]"'

test -n "$BASH_VERSION" && shopt -s cmdhist

# Aliases
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lA'
alias l='ls $LS_OPTIONS -lA'
alias cronall='for user in $(cut -f1 -d: /etc/passwd); do echo -e "$user:" && crontab -u $user -l | grep -v HEADER; echo "----------------"; done'

