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
alias vim="nvim"
alias dmenu="bemenu-run -n -l 30 --fn 'JetBrainsMono Nerd Font 10' --scrollbar always --counter alway"

PS1="\h@\u at \w "

export PATH="~/.local/bin:$PATH"

__foot_osc7() {
    printf '\033]7;file://%s%s\033\\' \
        "${HOSTNAME}" "$(printf '%s' "$PWD" | sed 's/ /%20/g')"
}

PROMPT_COMMAND="__foot_osc7${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

export EDITOR=nvim
export VISUAL=nvim
export NNN_OPTS="e"
