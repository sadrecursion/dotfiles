#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

alias ..="cd .."
alias l="ls -1 -a"
alias ll="ls -la"
alias grep="grep --color=auto"
alias rebash="source ~/.bashrc"
alias renvm="source /usr/share/nvm/init-nvm.sh"

PS1="\h@\u at \w "

export PATH="~/.local/bin:$PATH"
