# Export Omarchy current-theme colors for p10k
_omarchy_load_theme_colors() {
  local f=$HOME/.local/state/omarchy/current/theme/colors.toml
  [[ -r $f ]] || return
  local line k v
  while IFS= read -r line; do
    [[ $line == *=* ]] || continue
    k=${line%%=*}; v=${line#*=}
    k=${k// /}; v=${v// /}; v=${v//\"/}
    case $k in
      lighter_background) export OMARCHY_SURFACE=$v ;;
      foreground)         export OMARCHY_FG=$v ;;
      accent)             export OMARCHY_ACCENT=$v ;;
    esac
  done < $f
}
_omarchy_load_theme_colors
: ${OMARCHY_SURFACE:=236}

# On-demand: repaint current shell's prompt to the active theme
retheme() { _omarchy_load_theme_colors; p10k reload }
