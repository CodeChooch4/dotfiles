# dotfiles

macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package whose contents mirror the layout under `$HOME`, so stowing a package symlinks its files into place.

## What's here

| Package   | Contents                                                      | Links into                  |
| --------- | ------------------------------------------------------------- | --------------------------- |
| `zsh`     | `.zshrc`, `.zprofile`, `.p10k.zsh` (Powerlevel10k config)      | `~`                         |
| `git`     | `.gitconfig`                                                   | `~`                         |
| `nvim`    | Neovim config (kickstart-based, lazy.nvim, `lazy-lock.json`)   | `~/.config/nvim`            |
| `tmux`    | `tmux.conf` + plugin install script                            | `~/.config/tmux`            |
| `ghostty` | Ghostty terminal config                                        | `~/.config/ghostty`         |
| `omz`     | oh-my-zsh `custom/` dir (plugins + Powerlevel10k theme)        | `~/.oh-my-zsh` (see below)  |
| `fonts`   | SpaceMono Nerd Font (used by Ghostty) — copied, not stowed     | `~/Library/Fonts`           |

`MANIFEST.md` records what was captured from the original machine, including upstream repos for the oh-my-zsh plugins/theme and the full font list (since trimmed to SpaceMono in this repo).

## Setup on a new machine

1. **Install prerequisites**

   ```sh
   brew install stow git tmux neovim
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. **Clone and stow**

   ```sh
   git clone <this-repo> ~/dotfiles
   cd ~/dotfiles
   stow zsh git nvim tmux ghostty
   ```

   > oh-my-zsh's installer creates a default `~/.zshrc`; remove it before stowing `zsh` if stow reports a conflict.

3. **Link oh-my-zsh customizations** (this package targets `~/.oh-my-zsh`, not `~`)

   ```sh
   stow -t ~/.oh-my-zsh omz
   ```

   Alternatively, re-clone the customizations fresh (upstream URLs are in `MANIFEST.md`):
   - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
   - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
   - [powerlevel10k](https://github.com/romkatv/powerlevel10k)

4. **Install fonts** (Ghostty is configured for `SpaceMono Nerd Font Mono`)

   ```sh
   cp fonts/*.ttf ~/Library/Fonts/
   ```

5. **Finish up**
   - Open a new terminal — Powerlevel10k picks up `.p10k.zsh` automatically (run `p10k configure` to change it).
   - Launch `nvim`; lazy.nvim installs plugins pinned by `lazy-lock.json` on first run.
   - For tmux plugins, see `tmux/.config/tmux/install.sh`.

## Making changes

Edit files in this repo (the stowed symlinks point here), then commit. To add a new config, create a package directory mirroring its path under `$HOME` and run `stow <package>`.
