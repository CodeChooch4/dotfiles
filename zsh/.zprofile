# ~/.zprofile — login shell setup (portable: macOS + Linux)

# .NET SDK tools (same path on both OSes)
export PATH="$PATH:$HOME/.dotnet/tools"

if [[ "$OSTYPE" == darwin* ]]; then
  # --- macOS only ---
  # Python 3.11 framework
  [[ -d /Library/Frameworks/Python.framework/Versions/3.11/bin ]] && \
    export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"
  # Homebrew (Apple Silicon)
  [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == linux* ]]; then
  # --- Linux (Arch/Omarchy) ---
  # Linuxbrew only if you ever install it (you'll mostly use pacman)
  [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

