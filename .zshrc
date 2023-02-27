# -------------------------------- #
# Installation path
# -------------------------------- #
export ZSH="$HOME/.oh-my-zsh"

# -------------------------------- #
# Theme
# -------------------------------- #
ZSH_THEME="macovsky"

# -------------------------------- #
# Plugins
# -------------------------------- #
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/

# Autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax highlighting 
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Z-jump
# git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
 	zsh-z
)

source $ZSH/oh-my-zsh.sh

# -------------------------------- #
# User configuration
# -------------------------------- #

# Aliases
alias zshconfig='open ~/.zshrc'
alias nvimconfig="nvim ~/.config/nvim/lua/user"

alias git=hub
alias gp='git pull'
alias gP='git push'
alias gs='git status'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias ga='git add'
alias gA='git add -a'
alias gb='git branch'
alias gbd='git branch -d'

# -------------------------------- #
# Exports NVM
# -------------------------------- #
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
