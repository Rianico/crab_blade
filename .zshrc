eval "$(zellij setup --generate-auto-start zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# https://github.com/dreamsofautonomy/zensh/blob/main/.zshrc
# https://www.youtube.com/watch?v=ud7YxC33Z3w&ab_channel=DreamsofAutonomy
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice depth=1; zinit light olets/zsh-abbr


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets, more refer to https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
## ga: git add, gapa: git add -p
## gb: git branch, gba: git branch --all, gbr: git branch --remote
## gc: git commit
## gd: git diff, gds: git diff --staged
## glg: git log, glgg: git log --graph
## gm: git merge, gma: git merge --abort, gmc: git merge --continue
## grb: git rebase, grbc, grba
## gl: git pull, gp: git push
## gf: git fetch
## gsw: git switch, gswc: git switch -c
## gstl: git stash list, gstp: pop, gsta: apply, gstall: git stash --all
zinit snippet OMZP::git
zinit snippet OMZP::sudo
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::eza

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Load completions
autoload -Uz compinit && compinit

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# History
HISTSIZE=5000
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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export COLORTERM=truecolor

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"


export FZF_CTRL_T_OPTS="
--preview 'bat -n --color=always {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window up:10:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'"


# Homebrew
# export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
# export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
# export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/bottles"

# neovim
alias vim='nvim'
alias vi='nvim'
alias vimf="vim \$(fd --type file --exclude target  . ./ | fzf)"

alias cat='bat'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias llmg='f() { llm "$1" | glow -; }; f'

export DOCKER_DEFAULT_PLATFORM=linux/arm64

export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897

source /Users/zhengxk/.config/broot/launcher/bash/br


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/zhengxk/.lmstudio/bin"

# Created by `pipx` on 2025-02-11 04:33:06
export PATH="$PATH:/Users/zhengxk/.local/bin"

[[ -f ~/.secrets ]] && source ~/.secrets

export ABBR_GET_AVAILABLE_ABBREVIATION=1
export ABBR_LOG_AVAILABLE_ABBREVIATION=1
ABBR_QUIET=1
abbr import-aliases
