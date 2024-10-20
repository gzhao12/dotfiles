# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up Brew if on macOS
if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Load completions
autoload -U compinit && compinit

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"


# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
# Supposed to handle fzf-tab previewing but couldn't get it to work
# zinit light Freed-Wu/fzf-tab-source


# History
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Completion styling
# set min height on fzf prompt to 40% of term height (useful for preview)
zstyle ':fzf-tab:*' fzf-min-height 40

# disable sort when completing 'git checkout'
zstyle ':completion:*:git-checkout:*' sort false

# match case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# set list-colors to enable filename colorizing
# use LS_COLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# use manual colors (mimicking eza)
# zstyle ':completion:*' list-colors "di=34:fi=0:ln=36:pi=33:so=35:bd=32;40:cd=32;40:or=31;40"

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# make fzf-tab follow FZF_DEFAULT_OPTS (doesn't work with --tmux flag)
# zstyle ':fzf-tab:*' use-fzf-default-opts yes

# use custom script for previewing various files
zstyle ':fzf-tab:complete:*:*' fzf-preview '${HOME}/.config/fzf-preview.sh $realpath'


# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# Environment Variables
export PATH=/home/haru/.local/bin:$PATH:/usr/local/go/bin
export FZF_DEFAULT_OPTS="
  --walker-skip .git,node_modules,target
  --preview='${HOME}/.config/fzf-preview.sh {}'"

# Aliases
alias ls='eza --color=always --icons=auto'
alias -- -="cd -"
alias -- ~="cd ~"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
