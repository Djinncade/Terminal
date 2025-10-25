#!/bin/bash
# === DJINN TERMINAL MASTER INSTALLER V14 — Beast Edition (FIXED) ===
# DjinnCade Terminal Setup V14
# Copyright (c) 2025 DjinnCade Project
# Licensed under the MIT License – see the LICENSE file for details.
#
# Fixed: ALL file operations run from /userdata directory
# Removed: move, copy, delete functions
# Added: auto-cmd-wine command
set -euo pipefail

# Paths
BASE_DIR="/userdata/system/djinncade-addons/terminal"
CUSTOM_SH="$BASE_DIR/custom.sh"
STYLE_CONF="$BASE_DIR/djinn-config.conf"
KING_STATE="$BASE_DIR/djinn-king-state.conf"
BACKUPS_DIR="$BASE_DIR/djinn-backups"
UNINSTALL_SH="$BASE_DIR/djinncade-uninstall.sh"
REINSTALL_SH="/userdata/system/djinncade-addons/djinn-terminal-reinstaller.sh"
BASHRC="$HOME/.bashrc"
LOG_FILE="$BASE_DIR/djinn-log.txt"

mkdir -p "$BASE_DIR"
mkdir -p "$BACKUPS_DIR"
touch "$LOG_FILE"

# Helper: append log
log() { printf '%s %s\n' "$(date '+%F %T')" "$*" >> "$LOG_FILE"; }

# -----------------------------
# Dialog-theme chooser (install-time only)
# -----------------------------
clear
dialog --backtitle "🧞 Djinn Installer v14.1" --yesno "Pick a dialog theme now? (This sets dialog colors only; PS1/terminal colors are handled by djinn-style later.)" 10 60
if [ $? -eq 0 ]; then
  THEME=$(dialog --stdout --backtitle "Djinn Dialog Themes" --menu "Choose dialog theme:" 16 70 6 \
    1 "Emerald Blaze (Green on Black)" \
    2 "Arcane Blue (Cyan/Blue)" \
    3 "Inferno Red (Red/Yellow)" \
    4 "Mystic Purple (Magenta/Cyan)" \
    5 "Solar Gold (Yellow/White)" \
    6 "CRT Neon (Electric Blue / Hot Pink)")
else
  THEME=1
fi

# Map theme into variables stored in STYLE_CONF
case "$THEME" in
  1) D_SCREEN=CYAN; D_BOX=GREEN; D_TITLE=YELLOW; D_BORDER=GREEN ;;
  2) D_SCREEN=CYAN; D_BOX=BLUE;  D_TITLE=WHITE;  D_BORDER=CYAN ;;
  3) D_SCREEN=RED;  D_BOX=YELLOW; D_TITLE=WHITE;  D_BORDER=RED  ;;
  4) D_SCREEN=MAGENTA; D_BOX=CYAN; D_TITLE=WHITE; D_BORDER=MAGENTA ;;
  5) D_SCREEN=YELLOW; D_BOX=WHITE; D_TITLE=BLACK; D_BORDER=YELLOW ;;
  6) D_SCREEN=CYAN; D_BOX=BLUE; D_TITLE=MAGENTA; D_BORDER=CYAN ;;
  *) D_SCREEN=CYAN; D_BOX=GREEN; D_TITLE=YELLOW; D_BORDER=GREEN ;;
esac

# Default PS1 preset
cat > "$STYLE_CONF" <<EOF
# djinn-style config (written by installer v14.1)
PS1_PRESET="Classic Djinn"
PROMPT_SYMBOL_COLOR="RED"
PROMPT_USER_COLOR="CYAN"
PROMPT_PATH_COLOR="GREEN"
PROMPT_TEXT_COLOR="WHITE"
PROMPT_DJINN_COLOR="GREEN"

# Dialog colors (installer-chosen)
DIALOG_SCREEN_COLOR="$D_SCREEN"
DIALOG_BOX_COLOR="$D_BOX"
DIALOG_TITLE_COLOR="$D_TITLE"
DIALOG_BORDER_COLOR="$D_BORDER"
EOF

log "Installer: wrote initial style config to $STYLE_CONF (theme $THEME)"

# -----------------------------
# Write runtime custom.sh - FIXED FILE OPERATIONS VERSION
# -----------------------------
cat > "$CUSTOM_SH" <<'EOF'
#!/bin/bash
# Djinn Terminal v14.1 — Beast Edition (runtime) - FIXED FILE OPS
# Fixed: ALL file operations run from /userdata directory
# Removed: move, copy, delete functions
# Added: auto-cmd-wine command
# Copyright (c) 2025 DjinnCade Project
# Licensed under the MIT License – see the LICENSE file for details.

# Only for interactive shells
[[ $- != *i* ]] && return

BASE_DIR="/userdata/system/djinncade-addons/terminal"
STYLE_CONF="$BASE_DIR/djinn-config.conf"
KING_STATE="$BASE_DIR/djinn-king-state.conf"
BACKUPS_DIR="$BASE_DIR/djinn-backups"
ZYNN_CONF="$BASE_DIR/zynn.config"
LOG_FILE="$BASE_DIR/djinn-log.txt"

# safe tput wrapper
tput_safe() { tput "$@" 2>/dev/null || echo ""; }

# map color name -> tput
color_name_to_tput() {
  case "${1^^}" in
    BLACK) tput_safe setaf 0 ;;
    RED) tput_safe setaf 1 ;;
    GREEN) tput_safe setaf 2 ;;
    YELLOW) tput_safe setaf 3 ;;
    BLUE) tput_safe setaf 4 ;;
    MAGENTA) tput_safe setaf 5 ;;
    CYAN) tput_safe setaf 6 ;;
    WHITE) tput_safe setaf 7 ;;
    DEFAULT) echo "" ;;
    *) echo "" ;;
  esac
}

# Apply dialog RC from config
export DIALOGRC="/tmp/djinn_dialogrc"
apply_dialog_from_config() {
  if [ -f "$STYLE_CONF" ]; then
    . "$STYLE_CONF" 2>/dev/null || true
  fi
  DIALOG_SCREEN_COLOR="${DIALOG_SCREEN_COLOR:-CYAN}"
  DIALOG_BOX_COLOR="${DIALOG_BOX_COLOR:-GREEN}"
  DIALOG_TITLE_COLOR="${DIALOG_TITLE_COLOR:-YELLOW}"
  DIALOG_BORDER_COLOR="${DIALOG_BORDER_COLOR:-GREEN}"

  cat > "$DIALOGRC" <<DIALOGRC
use_shadow = OFF
use_colors = ON
screen_color = (${DIALOG_SCREEN_COLOR},BLACK,ON)
dialog_color = (${DIALOG_BOX_COLOR},BLACK,OFF)
title_color = (${DIALOG_TITLE_COLOR},BLACK,ON)
border_color = (${DIALOG_BORDER_COLOR},BLACK,OFF)
button_active_color = (BLACK,${DIALOG_BOX_COLOR},ON)
button_inactive_color = (WHITE,BLACK,OFF)
DIALOGRC
}

# FIXED: Proper PS1 generation
load_style_and_build_ps1() {
  PS1_PRESET="${PS1_PRESET:-Classic Djinn}"
  PROMPT_SYMBOL_COLOR="${PROMPT_SYMBOL_COLOR:-RED}"
  PROMPT_USER_COLOR="${PROMPT_USER_COLOR:-CYAN}"
  PROMPT_PATH_COLOR="${PROMPT_PATH_COLOR:-GREEN}"
  PROMPT_TEXT_COLOR="${PROMPT_TEXT_COLOR:-WHITE}"
  PROMPT_DJINN_COLOR="${PROMPT_DJINN_COLOR:-GREEN}"

  if [ -f "$STYLE_CONF" ]; then
    . "$STYLE_CONF" 2>/dev/null || true
  fi

  C_SYM="$(color_name_to_tput "$PROMPT_SYMBOL_COLOR")"
  C_USER="$(color_name_to_tput "$PROMPT_USER_COLOR")"
  C_PATH="$(color_name_to_tput "$PROMPT_PATH_COLOR")"
  C_TEXT="$(color_name_to_tput "$PROMPT_TEXT_COLOR")"
  C_DJINN="$(color_name_to_tput "$PROMPT_DJINN_COLOR")"
  RESET="$(tput_safe sgr0)"

  E_SYM="\\[${C_SYM}\\]"
  E_USER="\\[${C_USER}\\]" 
  E_PATH="\\[${C_PATH}\\]"
  E_TEXT="\\[${C_TEXT}\\]"
  E_DJINN="\\[${C_DJINN}\\]"
  E_RESET="\\[${RESET}\\]"

  NORMAL_PS="${E_SYM}🧞 ${E_USER}\\u@\\h:${E_PATH}\\W${E_SYM}\\$ ${E_USER}"
  DJINN_PS="${E_DJINN}🔮 ${E_USER}\\u@\\h:${E_PATH}\\W${E_DJINN}\\$ ${E_USER}"
  export PS1="$NORMAL_PS"
}

# show banner
show_banner() {
  load_style_and_build_ps1
  clear
  echo "${C_PATH}╔═══════════════════════════════════════════════════════════════════════════╗${RESET}"
  echo "${C_SYM}    ██████       ██ ██ ███    ██ ███    ██  ██████  █████  ██████  ███████ ${RESET}"
  echo "${C_SYM}    ██   ██      ██ ██ ████   ██ ████   ██ ██      ██   ██ ██   ██ ██      ${RESET}"
  echo "${C_SYM}    ██   ██      ██ ██ ██ ██  ██ ██ ██  ██ ██      ███████ ██   ██ █████   ${RESET}"
  echo "${C_SYM}    ██   ██ ██   ██ ██ ██  ██ ██ ██  ██ ██ ██      ██   ██ ██   ██ ██      ${RESET}"
  echo "${C_SYM}    ██████   █████  ██ ██   ████ ██   ████  ██████ ██   ██ ██████  ███████ ${RESET}"
  echo "${C_DJINN}                               PHOENIX REBORN                            ${RESET}"
  echo "${C_USER}                       READY IF YOU KNOW THE RIGHT COMMAND                ${RESET}"
  echo "${C_PATH}╚═══════════════════════════════════════════════════════════════════════════╝${RESET}"
}

# FIXED: file browser with proper path handling
file_browser() {
  local title="$1" start_dir="${2:-/userdata}" current_dir="$start_dir" sel path
  while true; do
    items=()
    shopt -s nullglob 2>/dev/null || true
    for it in "$current_dir"/*; do
      if [ -d "$it" ]; then items+=("D:$(basename "$it")" "📁 $(basename "$it")")
      elif [ -f "$it" ]; then items+=("F:$(basename "$it")" "📄 $(basename "$it")"); fi
    done
    shopt -u nullglob 2>/dev/null || true
    [ ${#items[@]} -eq 0 ] && items+=("EMPTY" "No files or folders")
    [ "$current_dir" != "/" ] && items=("..Parent" "⬆️ Parent" "${items[@]}")
    items+=("SELECT_HERE" "✅ Select current folder" "FSELECT" "Manual path entry" "CANCEL" "Cancel")
    sel=$(dialog --clear --stdout --backtitle "🧞 Djinncade" --title "$title" --menu "Current: $current_dir" 20 76 16 "${items[@]}") || { echo ""; return 1; }
    case "$sel" in
      "..Parent") 
        current_dir=$(dirname "$current_dir")
        ;;
      "SELECT_HERE") 
        echo "$current_dir"
        return 0 
        ;;
      "FSELECT")
        path=$(dialog --clear --stdout --backtitle "Select path" --fselect "$current_dir/" 20 76) || { echo ""; return 1; }
        echo "$path"
        return 0 
        ;;
      "CANCEL") echo ""; return 1 ;;
      "EMPTY") continue ;;
      D:*) 
        dname="${sel#D:}"
        current_dir="$current_dir/$dname"
        ;;
      F:*) 
        fname="${sel#F:}"
        path="$current_dir/$fname"
        echo "$path"
        return 0 
        ;;
      *) echo ""; return 1 ;;
    esac
  done
}

get_filename() { 
  basename "$1"
}

# KING state helpers
ensure_king_state() {
  if [ ! -f "$KING_STATE" ]; then
    cat > "$KING_STATE" <<K
# enabled commands (space-separated)
summon-djinn banish-djinn djinn-style djinn-cheats djinn-play djinn-king zynn djinn-help djinn-what auto-cmd-wine
K
  fi
}
read_enabled_commands() {
  if [ -f "$KING_STATE" ]; then
    read -r -a ENABLED <<< "$(grep -v '^#' "$KING_STATE" | tr '\n' ' ' | sed 's/^ *//;s/ *$//')"
  else
    ENABLED=()
  fi
}
is_command_enabled() {
  cmd="$1"; ensure_king_state; read_enabled_commands
  for e in "${ENABLED[@]}"; do [ "$e" = "$cmd" ] && return 0; done
  return 1
}
deny_msg() {
  msgs=(
"🧞 The Djinn slumbers in a swirl of incense. Try again later."
"🔮 The Djinn is on break — he ordered coffee."
"🌪️ The Djinn took an unexpected teleportation — be patient."
"⚙️ The Djinn is debugging the ether; come back shortly."
"🔔 The Djinn misremembered the password to his lamp."
)
  printf "%s\n" "${msgs[$RANDOM % ${#msgs[@]}]}"
}
require_enabled_or_die() {
  cmd="$1"
  if ! is_command_enabled "$cmd"; then
    dialog --clear --msgbox "$(deny_msg)" 8 60
    sleep 3
    clear
    show_banner
    return 1
  fi
  return 0
}

# FIXED: Summon / banish with proper dialog clearing
summon-djinn() {
  require_enabled_or_die "summon-djinn" || return 1
  export PS1="$DJINN_PS"
  show_banner
  dialog --clear --msgbox "🔮 The Djinn arrives — prompt switched." 6 50
  clear
  show_banner
}
banish-djinn() {
  require_enabled_or_die "banish-djinn" || return 1
  export PS1="$NORMAL_PS"
  show_banner
  dialog --clear --msgbox "🧞 The Djinn has left. Prompt restored." 6 50
  clear
  show_banner
}

# FIXED: djinn-help and djinn-what with proper dialog clearing
djinn-help() {
  require_enabled_or_die "djinn-help" || return 1
  msg=$'Visible Commands:\n\nsummon-djinn\nbanish-djinn\ndjinn-style\ndjinn-cheats\ndjinn-help\nauto-cmd-wine\n'
  dialog --clear --backtitle "🧞 Djinn Help" --msgbox "$msg" 12 60
  clear
  show_banner
}
djinn-what() {
  require_enabled_or_die "djinn-what" || return 1
  msg=$'Hidden / Advanced Commands:\n\ndjinn-play\ndjinn-king\nzynn\n'
  dialog --clear --backtitle "🧞 Djinn Secrets" --msgbox "$msg" 10 50
  clear
  show_banner
}

# FIXED: djinn-style - ALL dialogs clear properly
djinn-style() {
  require_enabled_or_die "djinn-style" || return 1

  PRESETS=(
    "Classic Djinn|🧞/🔮|RED|CYAN|GREEN|WHITE|GREEN"
    "Shadowfire|🩸/🔥|MAGENTA|RED|MAGENTA|YELLOW|RED"
    "Celestial Blue|✨/🔷|CYAN|WHITE|BLUE|WHITE|CYAN"
    "Emerald Pulse|💚/🌿|GREEN|GREEN|CYAN|WHITE|GREEN"
    "Infernal Ember|🔥/⚙️|RED|YELLOW|BLUE|WHITE|RED"
    "Aurora Flux|🌈/💫|MAGENTA|CYAN|BLUE|WHITE|MAGENTA"
    "Neon Mirage|💥/🕶️|BLUE|MAGENTA|YELLOW|CYAN|BLUE"
    "Quantum Gold|💎/⚡|YELLOW|YELLOW|CYAN|WHITE|YELLOW"
  )

  if [ -f "$STYLE_CONF" ]; then . "$STYLE_CONF" 2>/dev/null || true; fi

  while true; do
    choice=$(dialog --clear --stdout --backtitle "🎨 Djinn Style" --menu "Choose:" 20 80 16 \
      1 "Pick a PS1 preset" \
      2 "Edit individual prompt elements" \
      3 "Pick dialog theme" \
      4 "Save & Exit" \
      5 "Cancel") || { clear; show_banner; return 0; }
    
    case "$choice" in
      1)
        opts=()
        for p in "${PRESETS[@]}"; do
          name="${p%%|*}"
          opts+=("$name" "$name")
        done
        sel=$(dialog --clear --stdout --backtitle "PS1 presets" --menu "Pick preset:" 20 70 12 "${opts[@]}") || continue
        for p in "${PRESETS[@]}"; do
          name="${p%%|*}"
          if [ "$name" = "$sel" ]; then
            IFS='|' read -r _icon _icons sym usr path text dj <<< "$p"
            cat > "$STYLE_CONF" <<S
PS1_PRESET="$name"
PROMPT_SYMBOL_COLOR="${sym}"
PROMPT_USER_COLOR="${usr}"
PROMPT_PATH_COLOR="${path}"
PROMPT_TEXT_COLOR="${text}"
PROMPT_DJINN_COLOR="${dj}"
DIALOG_SCREEN_COLOR="${DIALOG_SCREEN_COLOR:-CYAN}"
DIALOG_BOX_COLOR="${DIALOG_BOX_COLOR:-GREEN}"
DIALOG_TITLE_COLOR="${DIALOG_TITLE_COLOR:-YELLOW}"
DIALOG_BORDER_COLOR="${DIALOG_BORDER_COLOR:-GREEN}"
S
            dialog --clear --msgbox "✅ Preset '$name' applied. Use 'summon-djinn' to preview." 7 60
            . "$STYLE_CONF" 2>/dev/null || true
            load_style_and_build_ps1
            clear
            show_banner
            break
          fi
        done
        ;;
      2)
        elements=("PROMPT_SYMBOL_COLOR" "PROMPT_USER_COLOR" "PROMPT_PATH_COLOR" "PROMPT_TEXT_COLOR" "PROMPT_DJINN_COLOR")
        labels=("Symbol" "User@Host" "Path" "Prompt Text" "Djinn Symbol")
        COLORS=(BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE DEFAULT)
        for i in "${!elements[@]}"; do
          cur="$(eval echo \${${elements[$i]}:-})"
          sel=$(dialog --clear --stdout --menu "Choose color for ${labels[$i]} (current: ${cur:-DEFAULT})" 14 40 9 "${COLORS[@]}") || continue
          eval "${elements[$i]}=\"$sel\""
          cat > "$STYLE_CONF" <<S2
PS1_PRESET="${PS1_PRESET:-Custom}"
PROMPT_SYMBOL_COLOR="${PROMPT_SYMBOL_COLOR:-RED}"
PROMPT_USER_COLOR="${PROMPT_USER_COLOR:-CYAN}"
PROMPT_PATH_COLOR="${PROMPT_PATH_COLOR:-GREEN}"
PROMPT_TEXT_COLOR="${PROMPT_TEXT_COLOR:-WHITE}"
PROMPT_DJINN_COLOR="${PROMPT_DJINN_COLOR:-GREEN}"
DIALOG_SCREEN_COLOR="${DIALOG_SCREEN_COLOR:-CYAN}"
DIALOG_BOX_COLOR="${DIALOG_BOX_COLOR:-GREEN}"
DIALOG_TITLE_COLOR="${DIALOG_TITLE_COLOR:-YELLOW}"
DIALOG_BORDER_COLOR="${DIALOG_BORDER_COLOR:-GREEN}"
S2
          . "$STYLE_CONF" 2>/dev/null || true
          load_style_and_build_ps1
        done
        dialog --clear --msgbox "✅ Element colors saved to $STYLE_CONF" 6 60
        clear
        show_banner
        ;;
      3)
        THEMES_MENU=(1 "Emerald Blaze" 2 "Arcane Blue" 3 "Inferno Red" 4 "Mystic Purple" 5 "Solar Gold" 6 "CRT Neon")
        T=$(dialog --clear --stdout --menu "Pick dialog theme:" 14 60 8 "${THEMES_MENU[@]}") || continue
        case "$T" in
          1) D_SCREEN=CYAN; D_BOX=GREEN; D_TITLE=YELLOW; D_BORDER=GREEN ;;
          2) D_SCREEN=CYAN; D_BOX=BLUE; D_TITLE=WHITE; D_BORDER=CYAN ;;
          3) D_SCREEN=RED;  D_BOX=YELLOW;D_TITLE=WHITE; D_BORDER=RED ;;
          4) D_SCREEN=MAGENTA; D_BOX=CYAN; D_TITLE=WHITE; D_BORDER=MAGENTA ;;
          5) D_SCREEN=YELLOW; D_BOX=WHITE; D_TITLE=BLACK; D_BORDER=YELLOW ;;
          6) D_SCREEN=CYAN; D_BOX=BLUE; D_TITLE=MAGENTA; D_BORDER=CYAN ;;
          *) D_SCREEN=CYAN; D_BOX=GREEN; D_TITLE=YELLOW; D_BORDER=GREEN ;;
        esac
        if [ -f "$STYLE_CONF" ]; then . "$STYLE_CONF" 2>/dev/null || true; fi
        cat > "$STYLE_CONF" <<S3
PS1_PRESET="${PS1_PRESET:-Custom}"
PROMPT_SYMBOL_COLOR="${PROMPT_SYMBOL_COLOR:-RED}"
PROMPT_USER_COLOR="${PROMPT_USER_COLOR:-CYAN}"
PROMPT_PATH_COLOR="${PROMPT_PATH_COLOR:-GREEN}"
PROMPT_TEXT_COLOR="${PROMPT_TEXT_COLOR:-WHITE}"
PROMPT_DJINN_COLOR="${PROMPT_DJINN_COLOR:-GREEN}"
DIALOG_SCREEN_COLOR="$D_SCREEN"
DIALOG_BOX_COLOR="$D_BOX"
DIALOG_TITLE_COLOR="$D_TITLE"
DIALOG_BORDER_COLOR="$D_BORDER"
S3
        apply_dialog_from_config
        dialog --clear --msgbox "✅ Dialog theme saved to $STYLE_CONF." 6 60
        clear
        show_banner
        ;;
      4)
        dialog --clear --msgbox "✅ Saved. Use 'summon-djinn' to preview PS1." 6 60
        clear
        show_banner
        return 0
        ;;
      5|"")
        clear
        show_banner
        return 0
        ;;
    esac
  done
}

# FIXED: djinn-king - properly handles cancel and clears ALL dialogs
djinn-king() {
  require_enabled_or_die "djinn-king" || return 1
  ensure_king_state
  read_enabled_commands
  all_cmds=(summon-djinn banish-djinn djinn-style djinn-cheats djinn-play djinn-king zynn djinn-help djinn-what auto-cmd-wine)
  opts=()
  for c in "${all_cmds[@]}"; do
    state=off
    for e in "${ENABLED[@]}"; do [ "$e" = "$c" ] && state=on; done
    opts+=("$c" "$c" "$state")
  done
  
  SELECT=$(dialog --clear --stdout --backtitle "🧞 Djinn King" --checklist "Toggle Djinn Commands (space toggles):" 20 76 12 "${opts[@]}")
  exit_code=$?
  
  if [ $exit_code -ne 0 ]; then
    clear
    show_banner
    return 0
  fi
  
  echo "# enabled commands" > "$KING_STATE"
  for s in $SELECT; do 
    s=$(echo "$s" | tr -d '"')
    echo -n "$s " >> "$KING_STATE"
  done
  echo "" >> "$KING_STATE"
  
  if ! grep -qw "zynn" "$KING_STATE" 2>/dev/null; then 
    rm -f "$ZYNN_CONF" 2>/dev/null || true
  else
    [ -f "$ZYNN_CONF" ] || echo "LAST_DIR=/userdata" > "$ZYNN_CONF"
  fi
  
  if grep -qw "summon-djinn" "$KING_STATE" 2>/dev/null; then 
    dialog --clear --msgbox "👑 The Djinn now walks among mortals." 6 50
  else 
    dialog --clear --msgbox "👑 The Djinn now slumbers in the shadows." 6 50
  fi
  
  clear
  show_banner
}

# FIXED: Zynn with proper dialog clearing
zynn() {
  require_enabled_or_die "zynn" || return 1
  if [ -f "$ZYNN_CONF" ]; then . "$ZYNN_CONF" 2>/dev/null || true; fi
  LAST_DIR="${LAST_DIR:-/userdata}"
  current_dir="$LAST_DIR"
  while true; do
    items=(); shopt -s nullglob 2>/dev/null || true
    for it in "$current_dir"/*; do
      [ -d "$it" ] && items+=("D:$(basename "$it")" "dir")
      [[ "$it" =~ \.(mp4|mkv|avi|mov|webm)$ ]] && items+=("F:$(basename "$it")" "video")
    done
    shopt -u nullglob 2>/dev/null || true
    [ ${#items[@]} -eq 0 ] && items+=("EMPTY" "No files")
    [ "$current_dir" != "/" ] && items=("..Parent" "⬆️ Parent" "${items[@]}")
    items+=("FSELECT" "Manual path entry" "EXIT" "Exit Zynn")
    SEL=$(dialog --clear --stdout --menu "Zynn - $current_dir" 20 76 16 "${items[@]}") || break
    case "$SEL" in
      "..Parent") current_dir=$(dirname "$current_dir") ;;
      "FSELECT") path=$(dialog --clear --stdout --fselect "$current_dir/" 20 76) || continue; current_dir="$path" ;;
      "EXIT") break ;;
      "EMPTY") continue ;;
      D:*) dname="${SEL#D:}"; current_dir="$current_dir/$dname" ;;
      F:*) fname="${SEL#F:}"; fp="$current_dir/$fname"; dialog --clear --msgbox "🎬 Playing: $fname\nPress OK to stop." 6 50; echo "LAST_DIR=$current_dir" > "$ZYNN_CONF"; mpv --fs "$fp" 2>/dev/null || true ;;
      *) continue ;;
    esac
  done
  clear
  show_banner
}

# FIXED: auto-cmd-wine with proper dialog clearing
auto-cmd-wine() {
  require_enabled_or_die "auto-cmd-wine" || return 1
  
  while true; do
    # Find Wineprefix directories
    wineprefixes=()

    # From /userdata/roms/windows
    for dir in /userdata/roms/windows/*; do
      if [ -d "$dir" ]; then
        if [[ "$dir" == *.pc ]] || [[ "$dir" == *.wine ]]; then
          wineprefixes+=( "$dir" )
        fi
      fi
    done

    # From /userdata/system/wine-bottles/windows
    while IFS= read -r dir; do
      wineprefixes+=( "$dir" )
    done < <(find /userdata/system/wine-bottles/windows -type d -name "*.wine")

    if [ ${#wineprefixes[@]} -eq 0 ]; then
      dialog --clear --msgbox "No Wineprefix directories found." 10 40
      return 1
    fi

    # Let user select Wineprefix
    prefix_options=()
    for prefix in "${wineprefixes[@]}"; do
      prefix_options+=( "$prefix" "" )
    done

    selected_prefix=$(dialog --clear --stdout --title "Select Wineprefix" \
      --menu "Choose Wineprefix for autorun.cmd:" \
      15 80 4 "${prefix_options[@]}")
    [ $? -ne 0 ] && { clear; show_banner; return 0; }

    # Find executable files
    mapfile -t files < <(find "$selected_prefix" -type f \( -iname "*.exe" -o -iname "*.bat" -o -iname "*.com" \))

    if [ ${#files[@]} -eq 0 ]; then
      dialog --clear --msgbox "No executable files found in $selected_prefix" 10 40
      continue
    fi

    # Build list with relative paths
    relative_files=()
    for file in "${files[@]}"; do
      rel=$(realpath --relative-to="$selected_prefix" "$file")
      relative_files+=( "$rel" "" )
    done

    selected_file=$(dialog --clear --stdout --title "Select Executable" \
      --menu "Choose executable (relative to Wineprefix root):" \
      15 80 4 "${relative_files[@]}")
    [ $? -ne 0 ] && { clear; show_banner; return 0; }

    # Create autorun.cmd
    exe_dir=$(dirname "$selected_file")
    exe_file=$(basename "$selected_file")

    if [[ "$exe_file" == *" "* ]]; then
      exe_cmd="\"$exe_file\""
    else
      exe_cmd="$exe_file"
    fi

    autorun_file="$selected_prefix/autorun.cmd"
    {
      if [ "$exe_dir" != "." ]; then
        echo "DIR=$exe_dir"
      fi
      echo "CMD=$exe_cmd"
    } > "$autorun_file"

    dialog --clear --msgbox "autorun.cmd created in:\n$selected_prefix" 10 40

    # Ask if user wants to process another
    dialog --clear --yesno "Create another autorun.cmd?" 7 40
    [ $? -ne 0 ] && break
  done

  clear
  show_banner
}

# FIXED: djinn-cheats - ALL file operations run from /userdata directory
djinn-cheats() {
  require_enabled_or_die "djinn-cheats" || return 1
  while true; do
    CH=$(dialog --clear --stdout --backtitle "🧞 Djinn Cheats" --menu "Tools" 22 80 12 \
      1 "Backup / Restore (media-only)" \
      2 "Zip files/folders" \
      3 "Unzip archive" \
      4 "Create SquashFS (.squashfs)" \
      5 "Extract SquashFS" \
      6 "System Info" \
      7 "Auto CMD Wine" \
      8 "Exit") || { clear; show_banner; break; }

    case "$CH" in
      1)
        # Backup/Restore logic
        mapfile -t MEDIA_DEV < <(find /media -mindepth 1 -maxdepth 1 -type d 2>/dev/null || true)
        if [ ${#MEDIA_DEV[@]} -eq 0 ]; then dialog --clear --msgbox "No /media devices found. Insert USB/HDD and retry." 8 60; clear; show_banner; continue; fi
        opts=(); for d in "${MEDIA_DEV[@]}"; do free_k=$(df -Pk "$d" 2>/dev/null | awk 'NR==2{print $4}'); free_mb=$((free_k/1024)); opts+=("$d" "$(basename "$d") — ${free_mb}MB free"); done
        DEST=$(dialog --clear --stdout --menu "Select /media destination:" 15 76 8 "${opts[@]}") || { clear; show_banner; continue; }
        mkdir -p "$DEST/djinn-backups"
        BACKUP_DIR="$DEST/djinn-backups"
        ACT=$(dialog --clear --stdout --menu "Choose action:" 12 50 3 1 "Create Backup" 2 "Restore Backup" 3 "Cancel") || { clear; show_banner; continue; }
        if [ "$ACT" = "1" ]; then
          mapfile -t UDIRS < <(find /userdata -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort)
          [ ${#UDIRS[@]} -eq 0 ] && { dialog --clear --msgbox "No folders under /userdata." 7 50; clear; show_banner; continue; }
          menu=(); for d in "${UDIRS[@]}"; do menu+=("$d" "$(basename "$d")" "off"); done
          SELECTED=$(dialog --clear --stdout --checklist "Select folders to include:" 20 78 12 "${menu[@]}") || { clear; show_banner; continue; }
          [ -z "$SELECTED" ] && { dialog --clear --msgbox "No folders selected." 7 50; clear; show_banner; continue; }
          INCLUDE=(); TOTAL_MB=0
          for f in $SELECTED; do f=$(echo "$f" | tr -d '"')
            if [ "$f" = "/userdata/roms" ]; then
              dialog --clear --yesno "Skip ROM subfolders smaller than 20MB?" 10 60
              if [ $? -eq 0 ]; then
                while IFS= read -r sub; do [ -d "$sub" ] || continue; sz=$(du -sm "$sub" 2>/dev/null | awk '{print $1}'); if [ "$sz" -ge 20 ]; then INCLUDE+=("$sub"); TOTAL_MB=$((TOTAL_MB + sz)); fi; done < <(find "$f" -mindepth 1 -maxdepth 1 -type d | sort)
              else
                sz=$(du -sm "$f" 2>/dev/null | awk '{print $1}'); INCLUDE+=("$f"); TOTAL_MB=$((TOTAL_MB + sz))
              fi
            else
              sz=$(du -sm "$f" 2>/dev/null | awk '{print $1}'); INCLUDE+=("$f"); TOTAL_MB=$((TOTAL_MB + sz))
            fi
          done
          [ ${#INCLUDE[@]} -eq 0 ] && { dialog --clear --msgbox "No folders to include after filtering." 7 50; clear; show_banner; continue; }
          free_kb=$(df -Pk "$DEST" 2>/dev/null | awk 'NR==2{print $4}')
          free_mb=$(( free_kb / 1024 ))
          required_mb=$(( (TOTAL_MB * 90) / 100 ))
          if [ "$free_mb" -lt "$required_mb" ]; then
            dialog --clear --msgbox "Not enough free space on $DEST.\nRequired (90% of raw total): ${required_mb}MB\nAvailable: ${free_mb}MB" 12 70
            clear; show_banner; continue
          fi
          OUT="$BACKUP_DIR/djinn-backup-$(date +%Y%m%d-%H%M%S).squashfs"
          dialog --clear --infobox "Creating backup...\n$OUT" 6 60
          ( mksquashfs "${INCLUDE[@]}" "$OUT" -comp zstd -noappend -progress 2>&1 | awk '/%/ { match($0,/([0-9]{1,3})%/,a); if(a[1]){ print a[1]; fflush(); } }' ) | dialog --clear --title "🧞 Creating Backup" --gauge "Compressing..." 10 70 0
          command -v sha256sum >/dev/null 2>&1 && sha256sum "$OUT" > "$OUT.sha256" 2>/dev/null || true
          dialog --clear --msgbox "✅ Backup complete:\n$OUT" 8 70
        else
          mapfile -t BK < <(find "$BACKUP_DIR" -maxdepth 1 -type f -name "*.squashfs" 2>/dev/null | sort)
          [ ${#BK[@]} -eq 0 ] && { dialog --clear --msgbox "No backups found on $DEST." 7 60; clear; show_banner; continue; }
          files=(); for b in "${BK[@]}"; do files+=("$b" "$(basename "$b")"); done
          REST=$(dialog --clear --stdout --menu "Select backup to restore:" 15 76 8 "${files[@]}") || { clear; show_banner; continue; }
          dialog --clear --yesno "Restore $REST ? This WILL overwrite /userdata" 12 70
          [ $? -ne 0 ] && { clear; show_banner; continue; }
          ( unsquashfs -f -d /userdata "$REST" 2>&1 | awk '/%/ { match($0,/([0-9]{1,3})%/,a); if(a[1]){ print a[1]; fflush(); } }' ) | dialog --clear --title "🧞 Restoring Backup" --gauge "Restoring..." 10 70 0
          dialog --clear --msgbox "✅ Restore complete." 7 60
        fi
        clear
        show_banner
        ;;
      2) # Zip - FIXED: runs from /userdata directory
        FOLDER=$(file_browser "Select folder to ZIP" "/userdata") || { clear; show_banner; continue; }
        DST=$(file_browser "Select DESTINATION for zip file" "/userdata") || { clear; show_banner; continue; }
        ZIP_NAME="$DST/$(get_filename "$FOLDER").zip"
        # FIXED: Run from /userdata directory
        (cd /userdata && zip -r "$ZIP_NAME" "${FOLDER#/userdata/}" >/dev/null 2>&1) && dialog --clear --msgbox "✅ Zipped to $ZIP_NAME" 7 60
        clear
        show_banner
        ;;
      3) # Unzip - FIXED: runs from /userdata directory
        ZIPF=$(file_browser "Select zip file to UNZIP" "/userdata") || { clear; show_banner; continue; }
        case "${ZIPF##*.}" in zip) true ;; *) dialog --clear --msgbox "❌ Not a .zip file" 7 50; clear; show_banner; continue ;; esac
        DST=$(file_browser "Select extraction folder" "/userdata") || { clear; show_banner; continue; }
        # FIXED: Run from /userdata directory
        (cd /userdata && unzip -o "$ZIPF" -d "$DST" >/dev/null 2>&1) && dialog --clear --msgbox "✅ Unzipped to $DST" 7 60
        clear
        show_banner
        ;;
      4) # Create SquashFS - FIXED: runs from /userdata directory
        if ! command -v mksquashfs >/dev/null 2>&1; then dialog --clear --msgbox "❌ mksquashfs not installed!" 7 50; clear; show_banner; continue; fi
        F=$(file_browser "Select folder for SquashFS" "/userdata") || { clear; show_banner; continue; }
        mapfile -t MEDIA < <(find /media -mindepth 1 -maxdepth 1 -type d 2>/dev/null || true)
        DST=""
        if [ ${#MEDIA[@]} -gt 0 ]; then
          opts=(); for m in "${MEDIA[@]}"; do free_k=$(df -Pk "$m" 2>/dev/null | awk 'NR==2{print $4}'); free_mb=$((free_k/1024)); opts+=("$m" "$(basename "$m") — ${free_mb}MB free"); done
          DST=$(dialog --clear --stdout --menu "Select /media destination (recommended):" 15 76 8 "${opts[@]}") || { clear; show_banner; continue; }
        fi
        if [ -z "$DST" ]; then DST=$(file_browser "Select DESTINATION for SquashFS" "/userdata") || { clear; show_banner; continue; }; fi
        OUT="$DST/$(basename "$F").squashfs"
        # FIXED: Run from /userdata directory with relative path
        (cd /userdata && mksquashfs "${F#/userdata/}" "$OUT" -comp zstd -noappend -progress 2>&1 | awk '/%/ { match($0,/([0-9]{1,3})%/,a); if(a[1]){ print a[1]; fflush(); } }' ) | dialog --clear --title "🧞 Creating SquashFS" --gauge "Compressing..." 10 70 0
        dialog --clear --msgbox "✅ Created: $OUT" 7 60
        clear
        show_banner
        ;;
      5) # Extract SquashFS - FIXED: runs from /userdata directory
        if ! command -v unsquashfs >/dev/null 2>&1; then dialog --clear --msgbox "❌ unsquashfs not installed!" 7 50; clear; show_banner; continue; fi
        SF=$(file_browser "Select SquashFS to extract" "/userdata") || { clear; show_banner; continue; }
        DST=$(file_browser "Select extraction folder" "/userdata") || { clear; show_banner; continue; }
        if [ "$(ls -A "$DST" 2>/dev/null)" ]; then dialog --clear --yesno "⚠️ Destination not empty: $DST\nOverwrite?" 10 60; [ $? -ne 0 ] && { clear; show_banner; continue; }; fi
        # FIXED: Run from /userdata directory
        (cd /userdata && unsquashfs -f -d "$DST" "$SF" 2>&1 | awk '/%/ { match($0,/([0-9]{1,3})%/,a); if(a[1]){ print a[1]; fflush(); } }' ) | dialog --clear --title "🧞 Extracting SquashFS" --gauge "Extracting..." 10 70 0
        dialog --clear --msgbox "✅ Extracted to $DST" 7 60
        clear
        show_banner
        ;;
      6) # System Info
        SYSFILE="/tmp/djinn_sysinfo.txt"
        {
          echo "=== SYSTEM INFORMATION ==="; echo ""
          if [ -f /etc/batocera-release ]; then cat /etc/batocera-release; else uname -a; fi
          echo ""; echo "--- CPU ---"; grep "model name" /proc/cpuinfo | head -1 2>/dev/null || true
          echo "Cores: $(nproc 2>/dev/null || echo ?)"
          echo ""; echo "--- MEMORY ---"; free -h 2>/dev/null || true
          echo ""; echo "--- DISKS ---"; df -h | grep -v tmpfs 2>/dev/null || true
          echo ""; echo "--- UPTIME ---"; uptime 2>/dev/null || true
        } > "$SYSFILE"
        dialog --clear --backtitle "System Info" --textbox "$SYSFILE" 24 80
        clear
        show_banner
        ;;
      7) # Auto CMD Wine
        auto-cmd-wine
        ;;
      8|"") 
        clear
        show_banner
        break 
        ;;
    esac
  done
}

# FIXED: djinn-play with proper dialog clearing
djinn-play() {
  require_enabled_or_die "djinn-play" || return 1
  GAMES_DIR="/userdata/roms"
  CONSOLES=("snes" "neogeo" "x68000")
  ALL_GAMES=()
  for console in "${CONSOLES[@]}"; do
    GAMELIST="$GAMES_DIR/$console/gamelist.xml"
    if [ -f "$GAMELIST" ]; then
      while IFS= read -r path; do [ -n "$path" ] && ALL_GAMES+=("$GAMES_DIR/$console/$path"); done < <(grep -oP "(?<=<path>).*?(?=</path>)" "$GAMELIST" 2>/dev/null)
    fi
  done
  if [ ${#ALL_GAMES[@]} -eq 0 ]; then dialog --clear --msgbox "No games found in SNES/NeoGeo/X68000 gamelists." 6 50; clear; show_banner; return; fi
  SELECTED_GAME="${ALL_GAMES[$RANDOM % ${#ALL_GAMES[@]}]}"
  echo "Launching: $SELECTED_GAME"
  retroarch -L /userdata/cores/*.so "$SELECTED_GAME" 2>/dev/null || true
  clear
  show_banner
}

# Export functions for interactive use
export -f summon-djinn banish-djinn djinn-help djinn-what djinn-style djinn-cheats djinn-play djinn-king zynn auto-cmd-wine 2>/dev/null || true

# On source: apply dialog and PS1/banners
apply_dialog_from_config
load_style_and_build_ps1
show_banner

EOF

chmod +x "$CUSTOM_SH"
log "Installer: wrote FIXED FILE OPERATIONS runtime $CUSTOM_SH"

# -----------------------------
# Write uninstaller
# -----------------------------
cat > "$UNINSTALL_SH" <<'EOF'
#!/bin/bash
# djinncade-uninstall.sh — removes addon and optionally backups
# DjinnCade Terminal Setup V14
# Copyright (c) 2025 DjinnCade Project
# Licensed under the MIT License – see the LICENSE file for details.
set -euo pipefail
BASE_DIR="/userdata/system/djinncade-addons/terminal"
CUSTOM_SH="$BASE_DIR/custom.sh"
STYLE_CONF="$BASE_DIR/djinn-config.conf"
BACKUPS="$BASE_DIR/djinn-backups"
REINSTALL="/userdata/system/djinncade-addons/djinn-terminal-reinstaller.sh"
BASHRC="$HOME/.bashrc"

dialog --clear --backtitle "🧞 Djinn Uninstaller" --yesno "Are you sure you want to remove Djinn Terminal?" 10 60
if [ $? -ne 0 ]; then echo "Aborted."; exit 0; fi

if [ -d "$BACKUPS" ]; then
  dialog --clear --backtitle "🧞 Djinn Uninstaller" --yesno "Also delete backups in $BACKUPS ?" 8 60
  delbk=$?
else
  delbk=1
fi

rm -f "$CUSTOM_SH" "$STYLE_CONF" 2>/dev/null || true
if [ $delbk -eq 0 ]; then rm -rf "$BACKUPS" 2>/dev/null || true; fi

if [ -f "$BASHRC" ]; then sed -i "\|source $CUSTOM_SH|d" "$BASHRC" 2>/dev/null || true; fi

mkdir -p "$(dirname "$REINSTALL")"
cat > "$REINSTALL" <<REINST
#!/bin/bash
echo "Placeholder reinstaller for Djinn Terminal."
echo "Run the original installer script to reinstall."
sleep 2
REINST
chmod +x "$REINSTALL" 2>/dev/null || true

dialog --clear --msgbox "Uninstalled. Reinstaller placeholder at: $REINSTALL" 8 60
clear
echo "Uninstalled Djinn Terminal."
exit 0
EOF

chmod +x "$UNINSTALL_SH"
log "Installer: wrote uninstaller $UNINSTALL_SH"

# -----------------------------
# Reinstaller placeholder
# -----------------------------
cat > "$REINSTALL_SH" <<'EOF'
#!/bin/bash
echo "Djinn Terminal reinstaller placeholder."
echo "Run original installer to reinstall."
sleep 2
EOF
chmod +x "$REINSTALL_SH"

# -----------------------------
# KING_STATE default (enable everything including auto-cmd-wine)
# -----------------------------
cat > "$KING_STATE" <<K
# enabled commands (space-separated)
summon-djinn banish-djinn djinn-style djinn-cheats djinn-play djinn-king zynn djinn-help djinn-what auto-cmd-wine
K

# -----------------------------
# Ensure .bashrc sources custom.sh
# -----------------------------
if [ -f "$BASHRC" ]; then
  if ! grep -qF "source $CUSTOM_SH" "$BASHRC"; then
    {
      echo ""
      echo "# Djinn Terminal addon (installed by installer v14.1 FIXED FILE OPS)"
      echo "if [ -f \"$CUSTOM_SH\" ]; then source \"$CUSTOM_SH\"; fi"
    } >> "$BASHRC"
  fi
else
  cat > "$BASHRC" <<BRC
# .bashrc created by Djinn Terminal installer
if [ -f "$CUSTOM_SH" ]; then source "$CUSTOM_SH"; fi
BRC
fi

# -----------------------------
# Final messages & self-remove
# -----------------------------
clear
cat <<BANNER
╔════════════════════════════════════════════════════════════════╗
🎉 Djinn Terminal V14.1 — Beast Edition (FIXED FILE OPS) installed to: $BASE_DIR
  - FIXED: ALL file operations run from /userdata directory
  - zip/unzip/squashfs/unsquashfs now work correctly
  - REMOVED: move, copy, delete functions
  - ADDED: auto-cmd-wine command for autorun.cmd creation
  - runtime: $CUSTOM_SH
  - style config: $STYLE_CONF
  - backups dir: $BACKUPS_DIR
  - uninstaller: $UNINSTALL_SH
  - log: $LOG_FILE
╚════════════════════════════════════════════════════════════════╝
BANNER

sleep 2
INSTALLER_PATH="$(realpath "$0" 2>/dev/null || echo "$0")"
if [ -f "$INSTALLER_PATH" ]; then rm -f "$INSTALLER_PATH" 2>/dev/null || true; echo "Installer removed."; fi
sleep 1
clear
echo "✅ Installation finished. Open a new shell or run: source $CUSTOM_SH"
echo "FIXED: zip/unzip/squashfs/unsquashfs now run from /userdata directory!"
exit 0
