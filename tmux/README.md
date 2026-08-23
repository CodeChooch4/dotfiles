# Tmux Configuration

A portable, feature-rich tmux configuration with automatic plugin management via TPM (Tmux Plugin Manager).

## Features

### Theme & Appearance
- **Catppuccin Mocha theme** with custom status bar design
- **Top-positioned status bar** with session, command, and path info
- **Custom window status styling** with activity indicators
- **Battery percentage** and **online status** indicators
- **Date and time display** in the status bar

### Plugins
- **tmux-battery** - Battery status in status bar
- **tmux-online-status** - Network connectivity indicator
- **catppuccin/tmux** - Beautiful Catppuccin theme (pinned to v2.1.2)
- **tmux-sensible** - Sensible default settings
- **tmux.nvim** - Seamless Neovim integration
- **tmux-resurrect** - Session persistence across reboots
- **tmux-continuum** - Automatic session saving/restoration

### Key Bindings & Behavior
- **Mouse support enabled**
- **Extended history** (30,000 lines)
- **Zero escape time delay** for responsive experience
- **Smart pane resizing** with vim-style navigation
- **Custom split bindings** (prefix + v/h for vertical/horizontal)
- **Toggle status bar** with backslash (\\)

## Quick Setup

### Prerequisites
- tmux (version 1.9 or higher)
- git
- zsh (configured as default shell)

### One-Command Installation

```bash
git clone <your-repo-url> ~/.config/tmux
cd ~/.config/tmux
./install.sh
```

### Manual Installation

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url> ~/.config/tmux
   ```

2. **Start tmux:**
   ```bash
   tmux
   ```

3. **Plugins will auto-install** on first run, or manually install with:
   ```
   prefix + I
   ```

## Directory Structure

```
~/.config/tmux/
├── tmux.conf          # Main configuration file
├── install.sh         # Automated setup script  
├── README.md          # This file
└── .gitignore         # Git ignore rules
```

Note: The `plugins/` directory is auto-managed by TPM and excluded from version control.

## Plugin Management

### Key Bindings
- **Install new plugins:** `prefix + I` 
- **Update plugins:** `prefix + U`
- **Remove unused plugins:** `prefix + Alt + u`

### Adding New Plugins
1. Add plugin line to `tmux.conf`:
   ```bash
   set -g @plugin 'author/plugin-name'
   ```
2. Reload tmux config: `prefix + r`
3. Install new plugins: `prefix + I`

## Key Bindings

| Binding | Action |
|---------|--------|
| `Ctrl + Space` | Prefix key |
| `prefix + r` | Reload configuration |
| `prefix + v` | Vertical split (opens in current path) |
| `prefix + h` | Horizontal split (opens in current path) |
| `prefix + I` | Install plugins |
| `prefix + U` | Update plugins |
| `prefix + Alt + u` | Remove unused plugins |
| `\\` | Toggle status bar |
| `Alt + h/j/k/l` | Resize panes (vim-style) |

## Customization

### Status Bar Colors
Colors are defined using Catppuccin theme variables:
- `@thm_bg` - Background color
- `@thm_green`, `@thm_red`, `@thm_blue` - Accent colors
- `@thm_overlay_0` - Border color

### Modifying Plugins
Edit the `# list of plugins` section in `tmux.conf` and reload with `prefix + r`.

### Theme Customization
The Catppuccin theme can be customized by modifying the flavor:
```bash
set -g @catppuccin_flavor 'mocha' # Options: latte, frappe, macchiato, mocha
```

## Troubleshooting

### Plugins Not Loading
1. Ensure TPM is installed: `ls ~/.config/tmux/plugins/tpm`
2. Manually install plugins: `~/.config/tmux/plugins/tpm/bin/install_plugins`
3. Restart tmux

### Colors Not Displaying Correctly
Ensure your terminal supports 256 colors and has proper `TERM` variable:
```bash
export TERM="xterm-256color"
```

### Permission Issues
Make sure the install script is executable:
```bash
chmod +x install.sh
```

## Compatibility

- **Operating Systems:** macOS, Linux
- **Tmux Versions:** 1.9+
- **Terminal Requirements:** 256-color support recommended

## Contributing

Feel free to submit issues and enhancement requests!

## License

This configuration is provided as-is under MIT license. Individual plugins maintain their own licenses.