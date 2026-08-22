
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set the theme
# ZSH_THEME="apple" # set by `omz`

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# User configuration
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias pn=pnpm
alias vim=nvim
alias vi=nvim
alias lg="lazygit"
alias ghpr="gh pr create --title '@coderabbitai' --body '@coderabbitai summary' && gh pr view --web"
alias cr="tuicr"

# pnpm
export PNPM_HOME="/Users/todddugan/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# anthropic
export ANTHROPIC_API_KEY="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"

# sst
export PATH="/Users/todddugan/.sst/bin:$PATH"

# Add custom paths and prioritize
export PATH="/opt/homebrew/bin/opt/mysql-client/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/System/Cryptexes/App/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/usr/local/share/dotnet:~/.dotnet/tools:$PATH"

# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
