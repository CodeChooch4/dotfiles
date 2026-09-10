[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach
# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# ===== Personal (ported from zsh) =====
alias bashconfig="${EDITOR:-nvim} ~/.bashrc"
alias pn=pnpm
alias npm='echo "npm sucks, use pnpm"; false'
alias vim=nvim
alias vi=nvim
alias lg=lazygit
alias ld=lazydocker
alias ghpr="gh pr create --title '@coderabbitai' --body '@coderabbitai summary' && gh pr view --web"
alias cr=tuicr
[[ -r ~/.zsh_secrets ]] && source ~/.zsh_secrets
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$HOME/.local/bin:$HOME/.sst/bin:$HOME/.dotnet/tools:$PNPM_HOME:$PATH"
# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

[[ ${BLE_VERSION-} ]] && ble-attach
