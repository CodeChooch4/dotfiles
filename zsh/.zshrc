# Powerlevel10k instant prompt — keep near the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
source "$ZSH/oh-my-zsh.sh"

# ---- aliases ----
alias zshconfig="${EDITOR:-nvim} ~/.zshrc"
alias ohmyzsh="${EDITOR:-nvim} ~/.oh-my-zsh"
alias pn=pnpm
alias npm='echo "npm sucks, use pnpm"; false'
alias vim=nvim
alias vi=nvim
alias lg="lazygit"
alias ghpr="gh pr create --title '@coderabbitai' --body '@coderabbitai summary' && gh pr view --web"
alias cr="tuicr"

# ---- secrets (NOT committed — kept in ~/.zsh_secrets, chmod 600) ----
[[ -r ~/.zsh_secrets ]] && source ~/.zsh_secrets

# ---- PATH / env (portable) ----
export PATH="$HOME/.local/bin:$HOME/.sst/bin:$HOME/.dotnet/tools:$PATH"
if [[ "$OSTYPE" == darwin* ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
  export PATH="/opt/homebrew/opt/mysql-client/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/share/dotnet:$PATH"
  [[ -e "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"  # iTerm2 (mac)
else
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi
export PATH="$PNPM_HOME:$PATH"

# ---- powerlevel10k: config + theme (loads from brew / pacman / omz-custom) ----
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
for _p10k in \
  /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme \
  /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme"; do
  [[ -r "$_p10k" ]] && source "$_p10k" && break
done
unset _p10k

