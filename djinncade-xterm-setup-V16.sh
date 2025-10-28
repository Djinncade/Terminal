#!/bin/bash
# === DJINN TERMINAL MASTER INSTALLER V16 — With Enhanced Wine Tools ===
# DjinnCade Terminal Setup V16
# Copyright (c) 2025 DjinnCade Project
# Licensed under the MIT License – see the LICENSE file for details.
#
# FIXED: Correct path to /userdata/system/djinncade-addons/.dialogrc (hidden file)
# FIXED: djinn-king-state.conf and zynn.config are now hidden files (.djinn-king-state.conf, .zynn.config)
# FIXED: Only Player 1 & 2 gamepad support (removed players 3-8)
# FIXED: Removed wine/network/keyboard from main commands (cheats only)
# FIXED: Fast return after permission denied messages
# NEW: Enhanced auto-wine-tools module with multi-genre gamepad mapping system
# NEW: Improved djinn-cheats with game type selection BEFORE file browser for SquashFS
# NEW: Complete Wine automation with autorun.cmd and controller config
# NEW: Multi-controller support for Wine prefixes
# NEW: Genre-specific Windows gamepad mapping (FPS, RPG, Racing, etc.)
# NEW: Profile management system for custom mappings
# NEW: Auto-deletes setup script after successful installation

set -euo pipefail

# Paths
BASE_DIR="/userdata/system/djinncade-addons/terminal"
MODULES_DIR="$BASE_DIR/modules"
CORES_DIR="$BASE_DIR/cores"
BACKUPS_DIR="$BASE_DIR/djinn-backups"
LOG_FILE="$BASE_DIR/djinn-log.txt"

# Create directory structure
mkdir -p "$BASE_DIR" "$MODULES_DIR" "$CORES_DIR" "$BACKUPS_DIR"
mkdir -p "/userdata/system/djinncade-addons"
touch "$LOG_FILE"

log() { printf '%s %s\n' "$(date '+%F %T')" "$*" >> "$LOG_FILE"; }

# -----------------------------
# Create Custom DialogRC File (HIDDEN)
# -----------------------------
cat > "/userdata/system/djinncade-addons/.dialogrc" <<'EOF'
# Run-time configuration file for dialog
#
# Automatically generated for DjinnCade Terminal
#
#
# Types of values:
#
# Number     -  <number>
# String     -  "string"
# Boolean    -  <ON|OFF>
# Attribute  -  (foreground,background,highlight?,underline?,reverse?)

# Set aspect-ration.
aspect = 0

# Set separator (for multiple widgets output).
separate_widget = ""

# Set tab-length (for textbox tab-conversion).
tab_len = 0

# Make tab-traversal for checklist, etc., include the list.
visit_items = OFF

# Shadow dialog boxes? This also turns on color.
use_shadow = OFF

# Turn color support ON or OFF
use_colors = ON

# Screen color
screen_color = (WHITE,BLACK,ON)

# Shadow color
shadow_color = (CYAN,BLACK,ON)

# Dialog box color
dialog_color = (WHITE,BLACK,OFF)

# Dialog box title color
title_color = (WHITE,BLACK,ON)

# Dialog box border color
border_color = (CYAN,BLACK,ON)

# Active button color
button_active_color = (BLACK,BLACK,ON)

# Inactive button color
button_inactive_color = dialog_color

# Active button key color
button_key_active_color = button_active_color

# Inactive button key color
button_key_inactive_color = (WHITE,BLACK,OFF)

# Active button label color
button_label_active_color = (CYAN,BLACK,ON)

# Inactive button label color
button_label_inactive_color = screen_color

# Input box color
inputbox_color = dialog_color

# Input box border color
inputbox_border_color = dialog_color

# Search box color
searchbox_color = dialog_color

# Search box title color
searchbox_title_color = title_color

# Search box border color
searchbox_border_color = shadow_color

# File position indicator color
position_indicator_color = title_color

# Menu box color
menubox_color = dialog_color

# Menu box border color
menubox_border_color = shadow_color

# Item color
item_color = dialog_color

# Selected item color
item_selected_color = button_active_color

# Tag color
tag_color = title_color

# Selected tag color
tag_selected_color = button_label_active_color

# Tag key color
tag_key_color = button_key_inactive_color

# Selected tag key color
tag_key_selected_color = (CYAN,BLACK,ON)

# Check box color
check_color = dialog_color

# Selected check box color
check_selected_color = button_active_color

# Up arrow color
uarrow_color = (YELLOW,WHITE,ON)

# Down arrow color
darrow_color = uarrow_color

# Item help-text color
itemhelp_color = dialog_color

# Active form text color
form_active_text_color = button_active_color

# Form text color
form_text_color = title_color

# Readonly form item color
form_item_readonly_color = (CYAN,WHITE,ON)

# Dialog box gauge color
gauge_color = title_color

# Dialog box border2 color
border2_color = shadow_color

# Input box border2 color
inputbox_border2_color = shadow_color

# Search box border2 color
searchbox_border2_color = shadow_color

# Menu box border2 color
menubox_border2_color = shadow_color
EOF

# -----------------------------
# Create Ports Launcher Files
# -----------------------------

# Create djinn-cheats.sh for Ports
cat > "/userdata/roms/ports/djinn-cheats.sh" <<'EOF'
#!/bin/bash
DIALOGRC=/userdata/system/djinncade-addons/.dialogrc DISPLAY=:0.0 xterm -fs 20 -maximized -fg white -bg black -fa "DejaVuSansMono" -en UTF-8 -e bash -c "
    clear
    echo -e '\e[32m🧞 Loading Djinn Terminal... \e[0m'
    sleep 1
    /bin/bash --rcfile <(echo '. ~/.bashrc; echo -e \"\e[33mRunning djinn-cheats...\e[0m\"; sleep 1; djinn-cheats')
    echo ''
    echo 'Press any key to close...'
    read -n1
"
EOF

chmod +x "/userdata/roms/ports/djinn-cheats.sh"

# Create djinn-cheats.sh.keys for Ports gamepad support (ONLY PLAYER 1 & 2)
cat > "/userdata/roms/ports/djinn-cheats.sh.keys" <<'EOF'
{
    "actions_player1": [
        {
            "trigger": "pageup",
            "type": "key",
            "target": "KEY_PAGEUP"
        },
        {
            "trigger": "pagedown",
            "type": "key",
            "target": "KEY_PAGEDOWN"
        },
        {
            "trigger": "up",
            "type": "key",
            "target": "KEY_UP"
        },
        {
            "trigger": "down",
            "type": "key",
            "target": "KEY_DOWN"
        },
        {
            "trigger": "left",
            "type": "key",
            "target": "KEY_LEFT"
        },
        {
            "trigger": "right",
            "type": "key",
            "target": "KEY_RIGHT"
        },
        {
            "trigger": "start",
            "type": "key",
            "target": "KEY_ENTER"
        },
        {
            "trigger": "a",
            "type": "key",
            "target": "KEY_SPACE"
        },
        {
            "trigger": "b",
            "type": "key",
            "target": "KEY_SPACE"
        },
        {
            "trigger": "x",
            "type": "key",
            "target": "KEY_ENTER"
        },
        {
            "trigger": "y",
            "type": "key",
            "target": "KEY_ENTER"
        },
        {
            "trigger": "joystick1up",
            "type": "key",
            "target": "KEY_UP"
        },
        {
            "trigger": "joystick1down",
            "type": "key",
            "target": "KEY_DOWN"
        },
        {
            "trigger": "joystick1left",
            "type": "key",
            "target": "KEY_LEFT"
        },
        {
            "trigger": "joystick1right",
            "type": "key",
            "target": "KEY_RIGHT"
        },
        {
            "trigger": [
                "hotkey",
                "start"
            ],
            "type": "key",
            "target": [
                "KEY_RIGHTALT",
                "KEY_F4"
            ]
        }
    ],
    "actions_player2": [
        {
            "trigger": "pageup",
            "type": "key",
            "target": "KEY_PAGEUP"
        },
        {
            "trigger": "pagedown",
            "type": "key",
            "target": "KEY_PAGEDOWN"
        },
        {
            "trigger": "up",
            "type": "key",
            "target": "KEY_UP"
        },
        {
            "trigger": "down",
            "type": "key",
            "target": "KEY_DOWN"
        },
        {
            "trigger": "left",
            "type": "key",
            "target": "KEY_LEFT"
        },
        {
            "trigger": "right",
            "type": "key",
            "target": "KEY_RIGHT"
        },
        {
            "trigger": "start",
            "type": "key",
            "target": "KEY_ENTER"
        },
        {
            "trigger": "a",
            "type": "key",
            "target": "KEY_SPACE"
        },
        {
            "trigger": "b",
            "type": "key",
            "target": "KEY_SPACE"
        },
        {
            "trigger": "x",
            "type": "key",
            "target": "KEY_ENTER"
        },
        {
            "trigger": "y",
            "type": "key",
            "target": "KEY_ENTER"
        },
        {
            "trigger": "joystick2up",
            "type": "key",
            "target": "KEY_DOWN"
        },
        {
            "trigger": "joystick2down",
            "type": "key",
            "target": "KEY_DOWN"
        },
        {
            "trigger": "joystick2left",
            "type": "key",
            "target": "KEY_LEFT"
        },
        {
            "trigger": "joystick2right",
            "type": "key",
            "target": "KEY_RIGHT"
        },
        {
            "trigger": [
                "hotkey",
                "start"
            ],
            "type": "key",
            "target": [
                "KEY_RIGHTALT",
                "KEY_F4"
            ]
        }
    ]
}
EOF

# -----------------------------
# Theme Selection
# -----------------------------
clear
dialog --backtitle "🧞 Djinn Modular Setup v16" --yesno "Pick a dialog theme now?" 10 60
if [ $? -eq 0 ]; then
  THEME=$(dialog --stdout --backtitle "Djinn Dialog Themes" --menu "Choose dialog theme:" 16 70 8 \
    1 "Classic Terminal (White/Black/Cyan)" \
    2 "Midnight Blue (Blue/White/Cyan)" \
    3 "Emerald Forest (Green/Black/Yellow)" \
    4 "Inferno Red (Red/Yellow/White)" \
    5 "Royal Purple (Magenta/Cyan/White)" \
    6 "Solarized Dark (Yellow/Blue/Cyan)" \
    7 "Matrix Green (Green/Black/Green)" \
    8 "CRT Amber (Yellow/Black/Red)")
else
  THEME=1
fi

case "$THEME" in
  1) D_SCREEN=WHITE; D_BOX=WHITE; D_TITLE=CYAN; D_BORDER=CYAN ;;      # Classic Terminal
  2) D_SCREEN=BLUE; D_BOX=BLUE; D_TITLE=WHITE; D_BORDER=CYAN ;;       # Midnight Blue
  3) D_SCREEN=GREEN; D_BOX=GREEN; D_TITLE=YELLOW; D_BORDER=YELLOW ;;  # Emerald Forest
  4) D_SCREEN=RED; D_BOX=RED; D_TITLE=YELLOW; D_BORDER=WHITE ;;       # Inferno Red
  5) D_SCREEN=MAGENTA; D_BOX=MAGENTA; D_TITLE=CYAN; D_BORDER=WHITE ;; # Royal Purple
  6) D_SCREEN=YELLOW; D_BOX=YELLOW; D_TITLE=BLUE; D_BORDER=CYAN ;;    # Solarized Dark
  7) D_SCREEN=GREEN; D_BOX=GREEN; D_TITLE=GREEN; D_BORDER=GREEN ;;    # Matrix Green
  8) D_SCREEN=YELLOW; D_BOX=YELLOW; D_TITLE=RED; D_BORDER=RED ;;      # CRT Amber
  *) D_SCREEN=WHITE; D_BOX=WHITE; D_TITLE=CYAN; D_BORDER=CYAN ;;      # Default Classic
esac

# -----------------------------
# Create Main Configuration
# -----------------------------
cat > "$BASE_DIR/djinn-config.conf" <<EOF
# djinn-style config (written by modular setup v16)
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

# System paths
BASE_DIR="$BASE_DIR"
MODULES_DIR="$MODULES_DIR"
CORES_DIR="$CORES_DIR"
BACKUPS_DIR="$BACKUPS_DIR"
LOG_FILE="$LOG_FILE"
EOF

# -----------------------------
# Create Core Utilities
# -----------------------------

# Core: Dialog and UI functions
cat > "$CORES_DIR/core-dialog.sh" <<'EOF'
#!/bin/bash
# Core Dialog Functions for Djinn Terminal

apply_dialog_from_config() {
  export DIALOGRC="/tmp/djinn_dialogrc"
  if [ -f "$BASE_DIR/djinn-config.conf" ]; then
    source "$BASE_DIR/djinn-config.conf"
  fi
  
  DIALOG_SCREEN_COLOR="${DIALOG_SCREEN_COLOR:-WHITE}"
  DIALOG_BOX_COLOR="${DIALOG_BOX_COLOR:-WHITE}"
  DIALOG_TITLE_COLOR="${DIALOG_TITLE_COLOR:-CYAN}"
  DIALOG_BORDER_COLOR="${DIALOG_BORDER_COLOR:-CYAN}"

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

# Safe tput wrapper
tput_safe() { 
  tput "$@" 2>/dev/null || echo "" 
}

# Color name to tput code
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

# File browser function
file_browser() {
  local title="$1" start_dir="${2:-/userdata}" current_dir
  if [ -z "$start_dir" ] || [ "$start_dir" = "." ] || [ "$start_dir" = ".parent" ]; then
    start_dir="/userdata"
  fi
  current_dir="$start_dir"
  local sel path
  while true; do
    items=()
    shopt -s nullglob 2>/dev/null || true
    for it in "$current_dir"/*; do
      if [ -d "$it" ]; then 
        items+=("D:$(basename "$it")" "📁 $(basename "$it")")
      elif [ -f "$it" ]; then 
        items+=("F:$(basename "$it")" "📄 $(basename "$it")")
      fi
    done
    shopt -u nullglob 2>/dev/null || true
    [ ${#items[@]} -eq 0 ] && items+=("EMPTY" "No files or folders")
    [ "$current_dir" != "/" ] && items=("..Parent" "⬆️ Parent" "${items[@]}")
    items+=("SELECT_HERE" "✅ Select current folder" "FSELECT" "Manual path entry" "CANCEL" "Cancel")
    
    sel=$(dialog --clear --stdout --backtitle "🧞 Djinncade" --title "$title" --menu "Current: $current_dir" 20 76 16 "${items[@]}") || { echo ""; return 1; }
    
    case "$sel" in
      "..Parent") current_dir=$(dirname "$current_dir") ;;
      "SELECT_HERE") echo "$current_dir"; return 0 ;;
      "FSELECT") 
        path=$(dialog --clear --stdout --backtitle "Select path" --fselect "$current_dir/" 20 76) || { echo ""; return 1; }
        echo "$path"
        return 0 
        ;;
      "CANCEL") echo ""; return 1 ;;
      "EMPTY") continue ;;
      D:*) dname="${sel#D:}"; current_dir="$current_dir/$dname" ;;
      F:*) fname="${sel#F:}"; path="$current_dir/$fname"; echo "$path"; return 0 ;;
      *) echo ""; return 1 ;;
    esac
  done
}

get_filename() { 
  basename "$1" 
}
EOF

# Core: Command permission system - FIXED: Fast return on denied
cat > "$CORES_DIR/core-permissions.sh" <<'EOF'
#!/bin/bash
# Core Permission System for Djinn Terminal

ensure_king_state() {
  if [ ! -f "$BASE_DIR/.djinn-king-state.conf" ]; then
    cat > "$BASE_DIR/.djinn-king-state.conf" <<K
# enabled commands (space-separated)
summon-djinn banish-djinn djinn-style djinn-cheats djinn-play djinn-king zynn djinn-help djinn-what
K
  fi
}

read_enabled_commands() {
  if [ -f "$BASE_DIR/.djinn-king-state.conf" ]; then
    read -r -a ENABLED <<< "$(grep -v '^#' "$BASE_DIR/.djinn-king-state.conf" | tr '\n' ' ' | sed 's/^ *//;s/ *$//')"
  else
    ENABLED=()
  fi
}

is_command_enabled() {
  local cmd="$1"
  ensure_king_state
  read_enabled_commands
  for e in "${ENABLED[@]}"; do 
    [ "$e" = "$cmd" ] && return 0
  done
  return 1
}

deny_msg() {
  local msgs=(
    "🧞 The Djinn slumbers in a swirl of incense. Try again later."
    "🔮 The Djinn is on break — he ordered coffee."
    "🌪️ The Djinn took an unexpected teleportation — be patient."
    "⚙️ The Djinn is debugging the ether; come back shortly."
    "🔔 The Djinn misremembered the password to his lamp."
  )
  printf "%s\n" "${msgs[$RANDOM % ${#msgs[@]}]}"
}

require_enabled_or_die() {
  local cmd="$1"
  if ! is_command_enabled "$cmd"; then
    dialog --clear --msgbox "$(deny_msg)" 8 60
    return 1  # FAST RETURN - no sleep, no banner reload
  fi
  return 0
}
EOF

# Core: PS1 and display functions
cat > "$CORES_DIR/core-display.sh" <<'EOF'
#!/bin/bash
# Core Display Functions for Djinn Terminal

load_style_and_build_ps1() {
  # Load config
  if [ -f "$BASE_DIR/djinn-config.conf" ]; then
    source "$BASE_DIR/djinn-config.conf"
  fi
  
  PS1_PRESET="${PS1_PRESET:-Classic Djinn}"
  PROMPT_SYMBOL_COLOR="${PROMPT_SYMBOL_COLOR:-RED}"
  PROMPT_USER_COLOR="${PROMPT_USER_COLOR:-CYAN}"
  PROMPT_PATH_COLOR="${PROMPT_PATH_COLOR:-GREEN}"
  PROMPT_TEXT_COLOR="${PROMPT_TEXT_COLOR:-WHITE}"
  PROMPT_DJINN_COLOR="${PROMPT_DJINN_COLOR:-GREEN}"

  # Get color codes
  C_SYM="$(color_name_to_tput "$PROMPT_SYMBOL_COLOR")"
  C_USER="$(color_name_to_tput "$PROMPT_USER_COLOR")"
  C_PATH="$(color_name_to_tput "$PROMPT_PATH_COLOR")"
  C_TEXT="$(color_name_to_tput "$PROMPT_TEXT_COLOR")"
  C_DJINN="$(color_name_to_tput "$PROMPT_DJINN_COLOR")"
  RESET="$(tput_safe sgr0)"

  # Create escape sequences
  E_SYM="\\[${C_SYM}\\]"
  E_USER="\\[${C_USER}\\]" 
  E_PATH="\\[${C_PATH}\\]"
  E_TEXT="\\[${C_TEXT}\\]"
  E_DJINN="\\[${C_DJINN}\\]"
  E_RESET="\\[${RESET}\\]"

  # Build PS1 strings
  NORMAL_PS="${E_SYM}🧞 ${E_USER}\\u@\\h:${E_PATH}\\W${E_SYM}\\$ ${E_USER}"
  DJINN_PS="${E_DJINN}🔮 ${E_USER}\\u@\\h:${E_PATH}\\W${E_DJINN}\\$ ${E_USER}"
  export PS1="$NORMAL_PS"
}

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
EOF

# -----------------------------
# Create ALL Module Files
# -----------------------------

# Module: djinn-style - FIXED with proper Save & Exit
cat > "$MODULES_DIR/module-style.sh" <<'EOF'
#!/bin/bash
# Module: djinn-style - PS1 and dialog theming

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

  # Load current config
  if [ -f "$BASE_DIR/djinn-config.conf" ]; then 
    source "$BASE_DIR/djinn-config.conf"
  fi

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
            cat > "$BASE_DIR/djinn-config.conf" <<S
PS1_PRESET="$name"
PROMPT_SYMBOL_COLOR="${sym}"
PROMPT_USER_COLOR="${usr}"
PROMPT_PATH_COLOR="${path}"
PROMPT_TEXT_COLOR="${text}"
PROMPT_DJINN_COLOR="${dj}"
DIALOG_SCREEN_COLOR="${DIALOG_SCREEN_COLOR:-WHITE}"
DIALOG_BOX_COLOR="${DIALOG_BOX_COLOR:-WHITE}"
DIALOG_TITLE_COLOR="${DIALOG_TITLE_COLOR:-CYAN}"
DIALOG_BORDER_COLOR="${DIALOG_BORDER_COLOR:-CYAN}"
BASE_DIR="$BASE_DIR"
MODULES_DIR="$MODULES_DIR"
CORES_DIR="$CORES_DIR"
BACKUPS_DIR="$BACKUPS_DIR"
LOG_FILE="$LOG_FILE"
S
            dialog --clear --msgbox "✅ Preset '$name' applied. Use 'summon-djinn' to preview." 7 60
            source "$BASE_DIR/djinn-config.conf"
            load_style_and_build_ps1
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
        done
        
        # Save changes
        cat > "$BASE_DIR/djinn-config.conf" <<S2
PS1_PRESET="${PS1_PRESET:-Custom}"
PROMPT_SYMBOL_COLOR="${PROMPT_SYMBOL_COLOR:-RED}"
PROMPT_USER_COLOR="${PROMPT_USER_COLOR:-CYAN}"
PROMPT_PATH_COLOR="${PROMPT_PATH_COLOR:-GREEN}"
PROMPT_TEXT_COLOR="${PROMPT_TEXT_COLOR:-WHITE}"
PROMPT_DJINN_COLOR="${PROMPT_DJINN_COLOR:-GREEN}"
DIALOG_SCREEN_COLOR="${DIALOG_SCREEN_COLOR:-WHITE}"
DIALOG_BOX_COLOR="${DIALOG_BOX_COLOR:-WHITE}"
DIALOG_TITLE_COLOR="${DIALOG_TITLE_COLOR:-CYAN}"
DIALOG_BORDER_COLOR="${DIALOG_BORDER_COLOR:-CYAN}"
BASE_DIR="$BASE_DIR"
MODULES_DIR="$MODULES_DIR"
CORES_DIR="$CORES_DIR"
BACKUPS_DIR="$BACKUPS_DIR"
LOG_FILE="$LOG_FILE"
S2
        source "$BASE_DIR/djinn-config.conf"
        load_style_and_build_ps1
        dialog --clear --msgbox "✅ Element colors saved." 6 60
        ;;
        
      3)
        THEMES_MENU=(
          1 "Classic Terminal (White/Black/Cyan)"
          2 "Midnight Blue (Blue/White/Cyan)" 
          3 "Emerald Forest (Green/Black/Yellow)"
          4 "Inferno Red (Red/Yellow/White)"
          5 "Royal Purple (Magenta/Cyan/White)"
          6 "Solarized Dark (Yellow/Blue/Cyan)"
          7 "Matrix Green (Green/Black/Green)"
          8 "CRT Amber (Yellow/Black/Red)"
        )
        T=$(dialog --clear --stdout --menu "Pick dialog theme:" 16 60 8 "${THEMES_MENU[@]}") || continue
        
        case "$T" in
          1) D_SCREEN=WHITE; D_BOX=WHITE; D_TITLE=CYAN; D_BORDER=CYAN ;;
          2) D_SCREEN=BLUE; D_BOX=BLUE; D_TITLE=WHITE; D_BORDER=CYAN ;;
          3) D_SCREEN=GREEN; D_BOX=GREEN; D_TITLE=YELLOW; D_BORDER=YELLOW ;;
          4) D_SCREEN=RED; D_BOX=RED; D_TITLE=YELLOW; D_BORDER=WHITE ;;
          5) D_SCREEN=MAGENTA; D_BOX=MAGENTA; D_TITLE=CYAN; D_BORDER=WHITE ;;
          6) D_SCREEN=YELLOW; D_BOX=YELLOW; D_TITLE=BLUE; D_BORDER=CYAN ;;
          7) D_SCREEN=GREEN; D_BOX=GREEN; D_TITLE=GREEN; D_BORDER=GREEN ;;
          8) D_SCREEN=YELLOW; D_BOX=YELLOW; D_TITLE=RED; D_BORDER=RED ;;
          *) D_SCREEN=WHITE; D_BOX=WHITE; D_TITLE=CYAN; D_BORDER=CYAN ;;
        esac
        
        cat > "$BASE_DIR/djinn-config.conf" <<S3
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
BASE_DIR="$BASE_DIR"
MODULES_DIR="$MODULES_DIR"
CORES_DIR="$CORES_DIR"
BACKUPS_DIR="$BACKUPS_DIR"
LOG_FILE="$LOG_FILE"
S3
        apply_dialog_from_config
        dialog --clear --msgbox "✅ Dialog theme saved." 6 60
        ;;
        
      4)
        dialog --clear --msgbox "✅ All changes saved successfully!" 6 50
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
    clear
    show_banner
  done
}
EOF

# Module: djinn-cheats - UPDATED: Game type selection BEFORE file browser for SquashFS
cat > "$MODULES_DIR/module-cheats.sh" <<'EOF'
#!/bin/bash
# Module: djinn-cheats - Complete file operations and system tools
# UPDATED: Always ask game type BEFORE opening file browser for Create/Extract SquashFS

djinn-cheats() {
  require_enabled_or_die "djinn-cheats" || return 1

  while true; do
    CH=$(dialog --clear --stdout --backtitle "🧞 Djinn Cheats" --menu "Tools" 22 80 16 \
      1 "Backup / Restore (media-only)" \
      2 "Zip files/folders" \
      3 "Unzip archive" \
      4 "Create SquashFS (.squashfs)" \
      5 "Extract SquashFS" \
      6 "System Info" \
      7 "Auto Wine Tools" \
      8 "Network Tools" \
      9 "Keyboard Setup" \
      10 "Exit") || { clear; show_banner; break; }

    case "$CH" in
      1)
        # Backup/Restore logic (unchanged)
        mapfile -t MEDIA_DEV < <(find /media -mindepth 1 -maxdepth 1 -type d 2>/dev/null || true)
        if [ ${#MEDIA_DEV[@]} -eq 0 ]; then 
          dialog --clear --msgbox "No /media devices found. Insert USB/HDD and retry." 8 60
          clear; show_banner; continue
        fi

        opts=()
        for d in "${MEDIA_DEV[@]}"; do 
          free_k=$(df -Pk "$d" 2>/dev/null | awk 'NR==2{print $4}'); 
          free_mb=$((free_k/1024))
          opts+=("$d" "$(basename "$d") — ${free_mb}MB free")
        done

        DEST=$(dialog --clear --stdout --menu "Select /media destination:" 15 76 8 "${opts[@]}") || { clear; show_banner; continue; }
        mkdir -p "$DEST/djinn-backups"
        BACKUP_DIR="$DEST/djinn-backups"

        ACT=$(dialog --clear --stdout --menu "Choose action:" 12 50 3 1 "Create Backup" 2 "Restore Backup" 3 "Cancel") || { clear; show_banner; continue; }

        if [ "$ACT" = "1" ]; then
          mapfile -t UDIRS < <(find /userdata -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort)
          [ ${#UDIRS[@]} -eq 0 ] && { dialog --clear --msgbox "No folders under /userdata." 7 50; clear; show_banner; continue; }

          menu=()
          for d in "${UDIRS[@]}"; do 
            menu+=("$d" "$(basename "$d")" "off")
          done

          SELECTED=$(dialog --clear --stdout --checklist "Select folders to include:" 20 78 12 "${menu[@]}") || { clear; show_banner; continue; }
          [ -z "$SELECTED" ] && { dialog --clear --msgbox "No folders selected." 7 50; clear; show_banner; continue; }

          INCLUDE=()
          TOTAL_MB=0
          for f in $SELECTED; do 
            f=$(echo "$f" | tr -d '"')
            if [ "$f" = "/userdata/roms" ]; then
              dialog --clear --yesno "Skip ROM subfolders smaller than 20MB?" 10 60
              if [ $? -eq 0 ]; then
                while IFS= read -r sub; do 
                  [ -d "$sub" ] || continue
                  sz=$(du -sm "$sub" 2>/dev/null | awk '{print $1}')
                  if [ "$sz" -ge 20 ]; then 
                    INCLUDE+=("$sub")
                    TOTAL_MB=$((TOTAL_MB + sz))
                  fi
                done < <(find "$f" -mindepth 1 -maxdepth 1 -type d | sort)
              else
                sz=$(du -sm "$f" 2>/dev/null | awk '{print $1}')
                INCLUDE+=("$f")
                TOTAL_MB=$((TOTAL_MB + sz))
              fi
            else
              sz=$(du -sm "$f" 2>/dev/null | awk '{print $1}')
              INCLUDE+=("$f")
              TOTAL_MB=$((TOTAL_MB + sz))
            fi
          done

          [ ${#INCLUDE[@]} -eq 0 ] && { dialog --clear --msgbox "No folders to include after filtering." 7 50; clear; show_banner; continue; }

          free_kb=$(df -Pk "$DEST" 2>/dev/null | awk 'NR==2{print $4}')
          free_mb=$(( free_kb / 1024 ))
          required_mb=$(( (TOTAL_MB * 90) / 100 ))

          if [ "$free_mb" -lt "$required_mb" ]; then
            dialog --clear --msgbox "Not enough free space on $DEST.\nRequired: ${required_mb}MB\nAvailable: ${free_mb}MB" 12 70
            clear; show_banner; continue
          fi

          OUT="$BACKUP_DIR/djinn-backup-$(date +%Y%m%d-%H%M%S).squashfs"
          dialog --clear --infobox "Creating backup...\n$OUT" 6 60

          ( mksquashfs "${INCLUDE[@]}" "$OUT" -comp zstd -noappend -progress 2>&1 | \
            awk '/%/ { match($0,/([0-9]{1,3})%/,a); if(a[1]){ print a[1]; fflush(); } }' ) | \
            dialog --clear --title "🧞 Creating Backup" --gauge "Compressing..." 10 70 0

          command -v sha256sum >/dev/null 2>&1 && sha256sum "$OUT" > "$OUT.sha256" 2>/dev/null || true
          dialog --clear --msgbox "✅ Backup complete:\n$OUT" 8 70

        elif [ "$ACT" = "2" ]; then
          mapfile -t BK < <(find "$BACKUP_DIR" -maxdepth 1 -type f -name "*.squashfs" 2>/dev/null | sort)
          [ ${#BK[@]} -eq 0 ] && { dialog --clear --msgbox "No backups found on $DEST." 7 60; clear; show_banner; continue; }

          files=()
          for b in "${BK[@]}"; do 
            files+=("$b" "$(basename "$b")")
          done

          REST=$(dialog --clear --stdout --menu "Select backup to restore:" 15 76 8 "${files[@]}") || { clear; show_banner; continue; }
          dialog --clear --yesno "Restore $REST ? This WILL overwrite /userdata" 12 70
          [ $? -ne 0 ] && { clear; show_banner; continue; }

          ( unsquashfs -f -d /userdata "$REST" 2>&1 | \
            awk '/%/ { match($0,/([0-9]{1,3})%/,a); if(a[1]){ print a[1]; fflush(); } }' ) | \
            dialog --clear --title "🧞 Restoring Backup" --gauge "Restoring..." 10 70 0
          dialog --clear --msgbox "✅ Restore complete." 7 60
        fi
        ;;

      2)
        # Zip files/folders (unchanged)
        FOLDER=$(file_browser "Select folder to ZIP" "/userdata") || { clear; show_banner; continue; }
        DST=$(file_browser "Select DESTINATION for zip file" "/userdata") || { clear; show_banner; continue; }
        ZIP_NAME="$DST/$(get_filename "$FOLDER").zip"

        if [ -f "$ZIP_NAME" ]; then
          dialog --clear --yesno "Zip file already exists:\n$ZIP_NAME\n\nOverwrite it?" 10 60
          if [ $? -ne 0 ]; then clear; show_banner; continue; fi
          rm -f "$ZIP_NAME"
        fi

        (cd /userdata && zip -r "$ZIP_NAME" "${FOLDER#/userdata/}" >/dev/null 2>&1)
        dialog --clear --msgbox "✅ Zipped to $ZIP_NAME" 7 60
        ;;

      3)
        # Unzip archive (unchanged)
        ZIPF=$(file_browser "Select zip file to UNZIP" "/userdata") || { clear; show_banner; continue; }
        case "${ZIPF##*.}" in zip) true ;; *) dialog --clear --msgbox "❌ Not a .zip file" 7 50; clear; show_banner; continue ;; esac
        DST=$(file_browser "Select extraction folder" "/userdata") || { clear; show_banner; continue; }
        (cd /userdata && unzip -o "$ZIPF" -d "$DST" >/dev/null 2>&1)
        dialog --clear --msgbox "✅ Unzipped to $DST" 7 60
        ;;

      4)
        # Create SquashFS - ask game type FIRST, then open file browser starting at chosen dest
        if ! command -v mksquashfs >/dev/null 2>&1; then
          dialog --clear --msgbox "❌ mksquashfs not installed!" 7 50
          clear; show_banner; continue
        fi

        GAME_TYPE=$(dialog --clear --stdout \
          --backtitle "Select Game Type" \
          --menu "Choose destination type BEFORE selecting the source folder:" 12 60 4 \
          1 "Windows PC Game (→ /userdata/roms/windows)" \
          2 "PS3 Game (→ /userdata/roms/ps3)" \
          3 "Other / Different (→ /userdata)" \
          4 "Cancel") || { clear; show_banner; continue; }

        case "$GAME_TYPE" in
          1) START_DIR="/userdata/roms/windows"; DST="/userdata/roms/windows"; mkdir -p "$DST"; GAME_TYPE_NAME="Windows" ;;
          2) START_DIR="/userdata/roms/ps3"; DST="/userdata/roms/ps3"; mkdir -p "$DST"; GAME_TYPE_NAME="PS3" ;;
          3) START_DIR="/userdata"; DST="/userdata"; GAME_TYPE_NAME="Other" ;;
          4) clear; show_banner; continue ;;
        esac

        # Now open file browser for the source folder, starting at the chosen directory
        F=$(file_browser "Select folder to create SquashFS from" "${START_DIR}") || { clear; show_banner; continue; }

        BASE_NAME=$(basename "$F")
        OUT="$DST/${BASE_NAME}.squashfs"

        if [ -f "$OUT" ]; then
          dialog --clear --yesno "SquashFS file already exists:\n$OUT\n\nOverwrite it?" 10 60
          if [ $? -ne 0 ]; then clear; show_banner; continue; fi
          rm -f "$OUT"
        fi

        dialog --clear --msgbox "🎮 Creating $GAME_TYPE_NAME Game SquashFS:\n\nSource: $F\nDestination: $OUT\n\nThis may take a while..." 12 70

        (cd /userdata && mksquashfs "${F#/userdata/}" "$OUT" -comp zstd -noappend -progress 2>&1 | \
          awk '/%/ { match($0,/([0-9]{1,3})%/,a); if(a[1]){ print a[1]; fflush(); } }' ) | \
          dialog --clear --title "🧞 Creating $GAME_TYPE_NAME Game SquashFS" --gauge "Compressing..." 10 70 0

        dialog --clear --msgbox "✅ $GAME_TYPE_NAME Game SquashFS Created!\n\nLocation: $OUT" 10 70
        ;;

      5)
        # Extract SquashFS - ask game type FIRST, then open file browser starting at chosen dest
        if ! command -v unsquashfs >/dev/null 2>&1; then
          dialog --clear --msgbox "❌ unsquashfs not installed!" 7 50
          clear; show_banner; continue
        fi

        GAME_TYPE=$(dialog --clear --stdout \
          --backtitle "Select Game Type" \
          --menu "Choose destination type BEFORE selecting the SquashFS file:" 12 60 4 \
          1 "Windows PC Game (→ /userdata/roms/windows)" \
          2 "PS3 Game (→ /userdata/roms/ps3)" \
          3 "Other / Different (→ /userdata)" \
          4 "Cancel") || { clear; show_banner; continue; }

        case "$GAME_TYPE" in
          1) START_DIR="/userdata/roms/windows"; DST="/userdata/roms/windows"; mkdir -p "$DST"; GAME_TYPE_NAME="Windows" ;;
          2) START_DIR="/userdata/roms/ps3"; DST="/userdata/roms/ps3"; mkdir -p "$DST"; GAME_TYPE_NAME="PS3" ;;
          3) START_DIR="/userdata"; DST="/userdata"; GAME_TYPE_NAME="Other" ;;
          4) clear; show_banner; continue ;;
        esac

        # Now open file browser to choose the .squashfs file (start in START_DIR so it 'jumps' there)
        SF=$(file_browser "Select SquashFS to extract" "${START_DIR}") || { clear; show_banner; continue; }

        # Validate extension (optional)
        case "${SF##*.}" in
          squashfs|sqfs) true ;;
          *) 
            dialog --clear --yesno "Selected file does not look like a .squashfs file.\n\nContinue anyway?" 10 60
            if [ $? -ne 0 ]; then clear; show_banner; continue; fi
            ;;
        esac

        # Check for conflicts (show up to 5)
        conflict_check=$(unsquashfs -l "$SF" 2>/dev/null | grep -v "squashfs-root" | while read -r line; do file="${line#*/}"; [ -f "$DST/$file" ] && echo "$file"; done | head -5)
        if [ -n "$conflict_check" ]; then
          dialog --clear --yesno "Some files already exist in destination:\n\n$conflict_check\n\nOverwrite existing files?" 12 70
          if [ $? -ne 0 ]; then clear; show_banner; continue; fi
        fi

        (cd /userdata && unsquashfs -f -d "$DST" "$SF" 2>&1 | \
          awk '/%/ { match($0,/([0-9]{1,3})%/,a); if(a[1]){ print a[1]; fflush(); } }' ) | \
          dialog --clear --title "🧞 Extracting $GAME_TYPE_NAME Game" --gauge "Extracting..." 10 70 0

        dialog --clear --msgbox "✅ $GAME_TYPE_NAME Game Extracted!\n\nLocation: $DST" 10 70
        ;;

      6)
        # System Info (unchanged)
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
        ;;

      7)
        auto-wine-tools
        ;;

      8)
        network-tools
        ;;

      9)
        keyboard-setup
        ;;

      10|"")
        clear
        show_banner
        break
        ;;
    esac

    clear
    show_banner
  done
}
EOF

# Module: Network Tools
cat > "$MODULES_DIR/module-network.sh" <<'EOF'
#!/bin/bash
# Module: network-tools - Network diagnostics and tools

network-tools() {
  # No permission check - only called from djinn-cheats
  
  while true; do
    choice=$(dialog --clear --stdout --backtitle "🌐 Djinn Network Tools" --menu "Network Utilities" 15 60 5 \
      1 "Wi-Fi Status & Networks" \
      2 "Speed Test" \
      3 "Network Interfaces" \
      4 "Ping Test" \
      5 "Exit") || { clear; return 0; }
    
    case "$choice" in
      1)
        if command -v iwconfig >/dev/null 2>&1; then
          wifi_info=$(iwconfig 2>/dev/null | grep -E "ESSID|Link Quality|Frequency" | head -5)
          if [ -n "$wifi_info" ]; then
            dialog --clear --title "📡 Wi-Fi Status" --msgbox "$wifi_info" 12 60
          else
            dialog --clear --msgbox "No Wi-Fi interface found or not connected." 8 50
          fi
          
          dialog --clear --yesno "Scan for available Wi-Fi networks? (This may take a moment)" 8 50
          if [ $? -eq 0 ]; then
            temp_scan="/tmp/wifi_scan.txt"
            dialog --clear --infobox "Scanning for Wi-Fi networks..." 5 40
            iwlist scan 2>/dev/null | grep -E "ESSID|Quality" | head -20 > "$temp_scan" 2>/dev/null || echo "Scan failed or no permissions" > "$temp_scan"
            dialog --clear --title "📶 Available Networks" --textbox "$temp_scan" 20 70
            rm -f "$temp_scan"
          fi
        else
          dialog --clear --msgbox "Wireless tools not available." 7 40
        fi
        ;;
      
      2)
        dialog --clear --yesno "This will test download speed using wget.\nIt will download a 100MB test file to /userdata/.\nContinue?" 10 50
        if [ $? -eq 0 ]; then
          TEST_FILE="/userdata/speedtest_100mb.file"
          TEST_URL="http://ipv4.download.thinkbroadband.com/100MB.zip"
          
          (
            echo "Starting speed test..."
            echo "Downloading 100MB test file to: $TEST_FILE"
            start_time=$(date +%s.%N)
            
            if wget -O "$TEST_FILE" --progress=dot:mega "$TEST_URL" 2>&1 | grep --line-buffered -o '[0-9]*%' | while read -r line; do
              percent=${line%\%}
              echo "$percent"
              echo "XXX"
              echo "Downloading test file... $line"
              echo "Download path: $TEST_FILE"
              echo "XXX"
            done; then
              end_time=$(date +%s.%N)
              duration=$(echo "$end_time - $start_time" | bc -l)
              
              if command -v bc >/dev/null 2>&1; then
                speed_mbps=$(echo "scale=2; 100 / $duration" | bc -l 2>/dev/null || echo "0")
              else
                speed_mbps=$(echo "scale=2; 100 / $duration" | awk '{printf "%.2f", $1}' 2>/dev/null || echo "0")
              fi
              
              file_size=$(du -h "$TEST_FILE" 2>/dev/null | cut -f1 || echo "Unknown")
              
              echo "100"
              echo "XXX"
              echo "Speed test complete!"
              echo "Download speed: $speed_mbps MB/s"
              echo "Time: ${duration%.*} seconds"
              echo "File size: $file_size"
              echo "Download path: $TEST_FILE"
              echo "XXX"
            else
              echo "100"
              echo "XXX"
              echo "Speed test failed!"
              echo "Could not download test file."
              echo "XXX"
            fi
          ) | dialog --clear --title "🚀 Speed Test - Downloading 100MB" --gauge "Initializing..." 15 70 0
          
          if [ -f "$TEST_FILE" ]; then
            dialog --clear --yesno "Speed test completed!\n\nDownload path: $TEST_FILE\n\nDelete the 100MB test file to free up space?" 12 60
            if [ $? -eq 0 ]; then
              rm -f "$TEST_FILE"
              dialog --clear --msgbox "Test file deleted." 6 40
            else
              dialog --clear --msgbox "Test file kept at: $TEST_FILE" 7 50
            fi
          fi
        fi
        ;;
      
      3)
        if_data=$(ip addr show 2>/dev/null || ifconfig 2>/dev/null || echo "Network tools not available")
        dialog --clear --title "🔌 Network Interfaces" --msgbox "$if_data" 20 70
        ;;
      
      4)
        target=$(dialog --clear --stdout --inputbox "Enter host to ping:" 10 50 "8.8.8.8")
        if [ $? -eq 0 ] && [ -n "$target" ]; then
          temp_ping="/tmp/ping_test.txt"
          (ping -c 5 "$target" 2>&1 || echo "Ping failed") > "$temp_ping"
          dialog --clear --title "🔄 Ping Results" --textbox "$temp_ping" 15 70
          rm -f "$temp_ping"
        fi
        ;;
      
      5|"")
        clear
        return 0
        ;;
    esac
  done
}
EOF

# Module: Keyboard Setup
cat > "$MODULES_DIR/module-keyboard.sh" <<'EOF'
#!/bin/bash
# Module: keyboard-setup - Keyboard and region configuration

keyboard-setup() {
  # No permission check - only called from djinn-cheats
  
  while true; do
    choice=$(dialog --clear --stdout --backtitle "⌨️ Djinn Keyboard Setup" --menu "Keyboard Configuration" 15 60 5 \
      1 "Set Keyboard Layout" \
      2 "Set Timezone/Region" \
      3 "Current Settings" \
      4 "Apply Changes" \
      5 "Exit") || { clear; return 0; }
    
    case "$choice" in
      1)
        layouts=(
          "us" "English (US)"
          "gb" "English (UK)"
          "fr" "French"
          "de" "German"
          "es" "Spanish"
          "it" "Italian"
          "pt" "Portuguese"
          "ru" "Russian"
          "jp" "Japanese"
          "cn" "Chinese"
          "kr" "Korean"
          "br" "Portuguese (Brazil)"
          "tr" "Turkish"
          "pl" "Polish"
          "nl" "Dutch"
          "se" "Swedish"
          "no" "Norwegian"
          "dk" "Danish"
          "fi" "Finnish"
        )
        
        current_layout=$(setxkbmap -query 2>/dev/null | grep layout | awk '{print $2}' || echo "us")
        selected_layout=$(dialog --clear --stdout --menu "Select Keyboard Layout\nCurrent: $current_layout" 20 60 12 "${layouts[@]}")
        
        if [ $? -eq 0 ] && [ -n "$selected_layout" ]; then
          if setxkbmap "$selected_layout" 2>/dev/null; then
            echo "KEYBOARD_LAYOUT=$selected_layout" > "/tmp/djinn_keyboard.conf"
            dialog --clear --msgbox "✅ Keyboard layout set to: $selected_layout\n\nChanges will be applied permanently when you select 'Apply Changes'" 10 60
          else
            dialog --clear --msgbox "❌ Failed to set keyboard layout.\nThis might require root privileges." 8 60
          fi
        fi
        ;;
      
      2)
        if command -v timedatectl >/dev/null 2>&1; then
          current_tz=$(timedatectl show --property=Timezone --value 2>/dev/null || echo "Unknown")
          dialog --clear --msgbox "Current timezone: $current_tz\n\nFor Batocera, timezone is usually set in the system settings.\nYou can view available timezones with: timedatectl list-timezones" 12 60
        else
          regions=(
            "America" "Americas"
            "Europe" "Europe"
            "Asia" "Asia"
            "Africa" "Africa"
            "Australia" "Australia/Pacific"
            "Pacific" "Pacific Islands"
          )
          
          selected_region=$(dialog --clear --stdout --menu "Select Region" 15 50 7 "${regions[@]}")
          if [ $? -eq 0 ] && [ -n "$selected_region" ]; then
            case "$selected_region" in
              "America") cities=("New_York" "Los_Angeles" "Chicago" "Denver" "Phoenix") ;;
              "Europe") cities=("London" "Paris" "Berlin" "Rome" "Madrid") ;;
              "Asia") cities=("Tokyo" "Shanghai" "Singapore" "Hong_Kong" "Seoul") ;;
              "Africa") cities=("Cairo" "Johannesburg" "Lagos" "Nairobi") ;;
              "Australia") cities=("Sydney" "Melbourne" "Perth" "Brisbane") ;;
              "Pacific") cities=("Auckland" "Fiji" "Honolulu") ;;
            esac
            
            city_opts=()
            for city in "${cities[@]}"; do
              city_opts+=("$selected_region/$city" "$city")
            done
            
            selected_tz=$(dialog --clear --stdout --menu "Select City" 15 50 7 "${city_opts[@]}")
            if [ $? -eq 0 ] && [ -n "$selected_tz" ]; then
              echo "TIMEZONE=$selected_tz" > "/tmp/djinn_timezone.conf"
              dialog --clear --msgbox "✅ Timezone set to: $selected_tz\n\nChanges will be applied when you select 'Apply Changes'" 10 60
            fi
          fi
        fi
        ;;
      
      3)
        current_info=""
        kb_info=$(setxkbmap -query 2>/dev/null | grep -E "layout|variant" || echo "Keyboard info not available")
        current_info+="Keyboard:\n$kb_info\n\n"
        
        if command -v timedatectl >/dev/null 2>&1; then
          tz_info=$(timedatectl status | grep -E "Time zone|Local time" | head -2)
          current_info+="Timezone:\n$tz_info"
        else
          current_info+="Timezone: timedatectl not available"
        fi
        
        dialog --clear --title "⌨️ Current Settings" --msgbox "$current_info" 15 70
        ;;
      
      4)
        changes_made=false
        apply_msg="Applied changes:\n"
        
        if [ -f "/tmp/djinn_keyboard.conf" ]; then
          source "/tmp/djinn_keyboard.conf"
          if [ -n "$KEYBOARD_LAYOUT" ]; then
            if setxkbmap "$KEYBOARD_LAYOUT" 2>/dev/null; then
              apply_msg+="✅ Keyboard: $KEYBOARD_LAYOUT\n"
              changes_made=true
            fi
          fi
        fi
        
        if [ -f "/tmp/djinn_timezone.conf" ]; then
          source "/tmp/djinn_timezone.conf"
          if [ -n "$TIMEZONE" ] && command -v timedatectl >/dev/null 2>&1; then
            dialog --clear --msgbox "Note: Setting timezone usually requires root privileges.\n\nYou can set it manually in Batocera system settings,\nor run: sudo timedatectl set-timezone $TIMEZONE" 12 60
            apply_msg+="⏰ Timezone: $TIMEZONE (may require manual setup)\n"
            changes_made=true
          fi
        fi
        
        if $changes_made; then
          dialog --clear --msgbox "$apply_msg" 10 60
        else
          dialog --clear --msgbox "No changes to apply." 7 40
        fi
        
        rm -f "/tmp/djinn_keyboard.conf" "/tmp/djinn_timezone.conf"
        ;;
      
      5|"")
        clear
        return 0
        ;;
    esac
  done
}
EOF

# Module: Auto Wine Tools - ENHANCED with multi-genre gamepad mapping system
cat > "$MODULES_DIR/module-wine-tools.sh" <<'EOF'
#!/bin/bash
# Module: module-wine-tools.sh - Complete Wine automation tools
# UPDATED: Multi-genre gamepad mapping system

auto-wine-tools() {
  # No permission check - only called from djinn-cheats

  CONFIG_DIR="/userdata/system/configs/gamepads"
  mkdir -p "$CONFIG_DIR"

  while true; do
    choice=$(dialog --clear --stdout --title "Wine Tools" \
      --menu "Choose an action:" 16 70 6 \
      1 "Create autorun.cmd (auto-launch for Wine)" \
      2 "Create controller auto-config (persistent multi-pad)" \
      3 "Create Windows Gamepad Mapping (by genre)" \
      4 "Manage Mapping Profiles" \
      5 "Exit")

    [ $? -ne 0 ] && { clear; return 0; }

    case $choice in
      1) create_autorun ;;
      2) create_controller_config ;;
      3) create_windows_gamepad_mapping ;;
      4) manage_mapping_profiles ;;
      5) clear; return 0 ;;
    esac
  done
}

# ==========================================================
# FUNCTION: Find Wine prefixes
# ==========================================================
find_wineprefixes() {
  local wineprefixes=()
  
  # Common Wine prefix locations
  local search_paths=(
    "/userdata/roms/windows/*"
    "/userdata/system/wine-bottles/windows/*"
    "/userdata/saves/windows/*"
  )
  
  for path in "${search_paths[@]}"; do
    for dir in $path; do
      if [[ -d "$dir" && ( "$dir" == *.pc || "$dir" == *.wine || -f "$dir/system.reg" ) ]]; then
        wineprefixes+=("$dir")
      fi
    done
  done
  
  printf '%s\n' "${wineprefixes[@]}"
}

# ==========================================================
# FUNCTION: Create autorun.cmd
# ==========================================================
create_autorun() {
  while true; do
    # --- Find Wineprefixes ---
    mapfile -t wineprefixes < <(find_wineprefixes)
    
    if [ ${#wineprefixes[@]} -eq 0 ]; then
      dialog --msgbox "No Wine prefix directories found.\n\nCommon locations:\n/userdata/roms/windows/\n/userdata/system/wine-bottles/windows/" 12 50
      break
    fi

    # Build menu options
    prefix_options=()
    for prefix in "${wineprefixes[@]}"; do
      prefix_name=$(basename "$prefix")
      prefix_options+=("$prefix" "$prefix_name")
    done

    selected_prefix=$(dialog --clear --stdout --title "Select Wine Prefix" \
      --menu "Choose prefix for autorun.cmd:" \
      15 80 6 "${prefix_options[@]}")
    [ $? -ne 0 ] && break

    # --- Find executables ---
    mapfile -t files < <(find "$selected_prefix" -maxdepth 3 -type f \
      \( -iname "*.exe" -o -iname "*.bat" -o -iname "*.com" \) \
      -not -path "*/windows/system32/*" \
      -not -path "*/windows/syswow64/*" 2>/dev/null | head -50)

    if [ ${#files[@]} -eq 0 ]; then
      dialog --msgbox "No executable files found in:\n$selected_prefix\n\nSupported: .exe, .bat, .com" 12 50
      continue
    fi

    # Build file menu with relative paths
    file_options=()
    for file in "${files[@]}"; do
      rel=$(realpath --relative-to="$selected_prefix" "$file" 2>/dev/null || echo "$file")
      file_options+=("$rel" "")
    done

    selected_file=$(dialog --clear --stdout --title "Select Executable" \
      --menu "Choose executable (relative to prefix):" \
      20 80 10 "${file_options[@]}")
    [ $? -ne 0 ] && break

    # Create autorun.cmd
    exe_dir=$(dirname "$selected_file")
    exe_file=$(basename "$selected_file")
    
    # Handle spaces in filenames
    if [[ "$exe_file" == *" "* ]]; then
      exe_cmd="\"$exe_file\""
    else
      exe_cmd="$exe_file"
    fi

    autorun_file="$selected_prefix/autorun.cmd"
    {
      echo "@echo off"
      [ "$exe_dir" != "." ] && echo "cd /d \"$exe_dir\""
      echo "echo Starting $exe_file..."
      echo "$exe_cmd"
      echo "if errorlevel 1 pause"
    } > "$autorun_file"

    chmod +x "$autorun_file"

    dialog --msgbox "✅ autorun.cmd created successfully!\n\nLocation: $autorun_file\n\nContents:\ncd \"$exe_dir\"\n$exe_cmd" 13 60

    dialog --yesno "Create another autorun.cmd?" 7 40
    [ $? -ne 0 ] && break
  done
}

# ==========================================================
# FUNCTION: Create controller configuration
# ==========================================================
create_controller_config() {
  while true; do
    # --- Find Wineprefixes ---
    mapfile -t wineprefixes < <(find_wineprefixes)
    
    if [ ${#wineprefixes[@]} -eq 0 ]; then
      dialog --msgbox "No Wine prefix directories found!" 10 40
      break
    fi

    # Build menu options
    prefix_options=()
    for prefix in "${wineprefixes[@]}"; do
      prefix_name=$(basename "$prefix")
      prefix_options+=("$prefix" "$prefix_name")
    done

    selected_prefix=$(dialog --clear --stdout --title "Select Wine Prefix" \
      --menu "Choose prefix for controller config:" \
      15 80 6 "${prefix_options[@]}")
    [ $? -ne 0 ] && break

    prefix_name=$(basename "$selected_prefix")
    mapping_file="$CONFIG_DIR/${prefix_name}_controllers.conf"
    
    # --- Detect controllers ---
    controllers=($(find /dev/input -name "js*" 2>/dev/null | sort))
    if [ ${#controllers[@]} -eq 0 ]; then
      dialog --msgbox "No controllers detected!\n\nPlease connect controllers and try again." 10 50
      continue
    fi

    # --- Generate mappings ---
    mappings_combined=""
    index=0
    > "$mapping_file"  # Clear old mappings
    
    for dev in "${controllers[@]}"; do
      # Get controller info
      model=$(udevadm info --query=property --name="$dev" 2>/dev/null | grep -E "ID_MODEL=|ID_NAME=" | cut -d= -f2 | head -1)
      [ -z "$model" ] && model="Controller_$index"
      
      # Get GUID (using batocera's controller tools if available)
      guid=""
      if command -v batocera-sdl2-gamepad-tool &>/dev/null; then
        guid=$(batocera-sdl2-gamepad-tool --guid-only "$index" 2>/dev/null)
      elif command -v sdl2-gamepad-tool &>/dev/null; then
        guid=$(sdl2-gamepad-tool --guid-only "$index" 2>/dev/null)
      fi
      
      if [ -n "$guid" ]; then
        echo "# Controller $((index+1)): $model" >> "$mapping_file"
        echo "$guid" >> "$mapping_file"
        
        if [ -n "$mappings_combined" ]; then
          mappings_combined="$mappings_combined;$guid"
        else
          mappings_combined="$guid"
        fi
        ((index++))
      fi
    done

    if [ -z "$mappings_combined" ]; then
      dialog --msgbox "❌ No valid controller mappings generated!" 10 40
      continue
    fi

    # --- Update Wine registry ---
    env_file="$selected_prefix/user.reg"
    if [ ! -f "$env_file" ]; then
      dialog --msgbox "Wine registry not found:\n$env_file" 10 50
      continue
    fi

    # Create or update Environment section
    if ! grep -q "^\[Software\\\\Wine\\\\Environment\]" "$env_file"; then
      echo "" >> "$env_file"
      echo "[Software\\\\Wine\\\\Environment]" >> "$env_file"
    fi

    # Update SDL_GAMECONTROLLERCONFIG
    if grep -q "\"SDL_GAMECONTROLLERCONFIG\"" "$env_file"; then
      sed -i "s|\"SDL_GAMECONTROLLERCONFIG\"=.*|\"SDL_GAMECONTROLLERCONFIG\"=\"$mappings_combined\"|" "$env_file"
    else
      # Ensure we're in the right section
      if ! grep -q "^\[Software\\\\Wine\\\\Environment\]" "$env_file"; then
        echo "" >> "$env_file"
        echo "[Software\\\\Wine\\\\Environment]" >> "$env_file"
      fi
      echo "\"SDL_GAMECONTROLLERCONFIG\"=\"$mappings_combined\"" >> "$env_file"
    fi

    dialog --msgbox "✅ Multi-controller configuration applied!\n\nPrefix: $prefix_name\nControllers: $index detected\nConfig: $mapping_file\nRegistry: $env_file" 12 60

    dialog --yesno "Configure another Wine prefix?" 7 50
    [ $? -ne 0 ] && break
  done
}

# ==========================================================
# FUNCTION: Manage Mapping Profiles
# ==========================================================
manage_mapping_profiles() {
  PROFILES_DIR="/userdata/system/djinncade-addons/terminal/gamepad-profiles"
  mkdir -p "$PROFILES_DIR"
  
  while true; do
    choice=$(dialog --clear --stdout --title "Mapping Profiles" \
      --menu "Profile Management:" 15 60 5 \
      1 "View All Profiles" \
      2 "Create Custom Profile" \
      3 "Delete Profile" \
      4 "Back")
    
    [ $? -ne 0 ] && break
    
    case $choice in
      1) view_profiles ;;
      2) create_custom_profile ;;
      3) delete_profile ;;
      4) break ;;
    esac
  done
}

view_profiles() {
  profiles=()
  while IFS= read -r -d '' profile; do
    profile_name=$(basename "$profile" .json)
    profiles+=("$profile_name" "$profile")
  done < <(find "$PROFILES_DIR" -name "*.json" -type f -print0 2>/dev/null)
  
  if [ ${#profiles[@]} -eq 0 ]; then
    dialog --msgbox "No custom profiles found.\n\nDefault profiles are built-in:\n• FPS\n• RPG\n• Racing\n• Platformer\n• Fighting\n• Strategy" 12 60
  else
    profile_list=""
    for ((i=0; i<${#profiles[@]}; i+=2)); do
      profile_list+="• ${profiles[i]}\n"
    done
    dialog --msgbox "Custom Profiles:\n\n$profile_list" 15 60
  fi
}

create_custom_profile() {
  profile_name=$(dialog --clear --stdout --inputbox "Enter profile name:" 10 40)
  [ -z "$profile_name" ] && return
  
  # Select base template
  base_template=$(dialog --clear --stdout \
    --menu "Select base template:" 15 60 6 \
    "fps" "First Person Shooter" \
    "rpg" "Role Playing Game" \
    "racing" "Racing Game" \
    "platformer" "Platformer" \
    "fighting" "Fighting Game" \
    "strategy" "Strategy Game")
  
  [ $? -ne 0 ] && return
  
  # Load the base template
  case $base_template in
    "fps") create_fps_mapping > "/dev/null" ;;
    "rpg") create_rpg_mapping > "/dev/null" ;;
    "racing") create_racing_mapping > "/dev/null" ;;
    "platformer") create_platformer_mapping > "/dev/null" ;;
    "fighting") create_fighting_mapping > "/dev/null" ;;
    "strategy") create_strategy_mapping > "/dev/null" ;;
  esac
  
  # Let user customize (simplified for now)
  dialog --msgbox "Custom profile '$profile_name' created based on $base_template template.\n\nYou can manually edit the JSON file to customize further." 10 60
  
  # For now, we'll just copy the base template
  cp "/tmp/${base_template}_mapping.json" "$PROFILES_DIR/${profile_name}.json" 2>/dev/null || true
}

delete_profile() {
  profiles=()
  while IFS= read -r -d '' profile; do
    profile_name=$(basename "$profile" .json)
    profiles+=("$profile_name" "")
  done < <(find "$PROFILES_DIR" -name "*.json" -type f -print0 2>/dev/null)
  
  if [ ${#profiles[@]} -eq 0 ]; then
    dialog --msgbox "No custom profiles to delete." 7 40
    return
  fi
  
  profile_to_delete=$(dialog --clear --stdout \
    --menu "Select profile to delete:" 15 60 5 "${profiles[@]}")
  
  [ -z "$profile_to_delete" ] && return
  
  if dialog --yesno "Delete profile '$profile_to_delete'?" 8 40; then
    rm -f "$PROFILES_DIR/${profile_to_delete}.json"
    dialog --msgbox "Profile '$profile_to_delete' deleted." 7 40
  fi
}

# ==========================================================
# FUNCTION: Genre-Specific Mapping Creators
# ==========================================================

create_fps_mapping() {
  cat > "/tmp/fps_mapping.json" << 'FPS_MAPPING'
{
    "name": "FPS - First Person Shooter",
    "description": "Optimized for first-person shooters like Call of Duty, Battlefield, Halo",
    "mapping": {
        "actions_player1": [
            {"trigger": "joystick1left", "type": "key", "target": "KEY_A"},
            {"trigger": "joystick1right", "type": "key", "target": "KEY_D"},
            {"trigger": "joystick1up", "type": "key", "target": "KEY_W"},
            {"trigger": "joystick1down", "type": "key", "target": "KEY_S"},
            {"trigger": "joystick2left", "type": "key", "target": "KEY_LEFT"},
            {"trigger": "joystick2right", "type": "key", "target": "KEY_RIGHT"},
            {"trigger": "joystick2up", "type": "key", "target": "KEY_UP"},
            {"trigger": "joystick2down", "type": "key", "target": "KEY_DOWN"},
            {"trigger": "a", "type": "key", "target": "KEY_SPACE"},
            {"trigger": "b", "type": "key", "target": "KEY_C"},
            {"trigger": "x", "type": "key", "target": "KEY_R"},
            {"trigger": "y", "type": "key", "target": "KEY_F"},
            {"trigger": "l1", "type": "key", "target": "KEY_Q"},
            {"trigger": "r1", "type": "key", "target": "KEY_G"},
            {"trigger": "l2", "type": "key", "target": "KEY_LEFTSHIFT"},
            {"trigger": "r2", "type": "key", "target": "KEY_E"},
            {"trigger": "l3", "type": "key", "target": "KEY_LEFTSHIFT"},
            {"trigger": "r3", "type": "key", "target": "KEY_V"},
            {"trigger": "start", "type": "key", "target": "KEY_ESC"},
            {"trigger": "select", "type": "key", "target": "KEY_TAB"},
            {"trigger": "pageup", "type": "key", "target": "KEY_1"},
            {"trigger": "pagedown", "type": "key", "target": "KEY_2"}
        ]
    }
}
FPS_MAPPING
  echo "/tmp/fps_mapping.json"
}

create_rpg_mapping() {
  cat > "/tmp/rpg_mapping.json" << 'RPG_MAPPING'
{
    "name": "RPG - Role Playing Game", 
    "description": "Optimized for RPGs like Skyrim, Witcher, Fallout, Mass Effect",
    "mapping": {
        "actions_player1": [
            {"trigger": "joystick1left", "type": "key", "target": "KEY_A"},
            {"trigger": "joystick1right", "type": "key", "target": "KEY_D"},
            {"trigger": "joystick1up", "type": "key", "target": "KEY_W"},
            {"trigger": "joystick1down", "type": "key", "target": "KEY_S"},
            {"trigger": "joystick2left", "type": "key", "target": "KEY_LEFT"},
            {"trigger": "joystick2right", "type": "key", "target": "KEY_RIGHT"},
            {"trigger": "joystick2up", "type": "key", "target": "KEY_UP"},
            {"trigger": "joystick2down", "type": "key", "target": "KEY_DOWN"},
            {"trigger": "a", "type": "key", "target": "KEY_SPACE"},
            {"trigger": "b", "type": "key", "target": "KEY_E"},
            {"trigger": "x", "type": "key", "target": "KEY_R"},
            {"trigger": "y", "type": "key", "target": "KEY_F"},
            {"trigger": "l1", "type": "key", "target": "KEY_TAB"},
            {"trigger": "r1", "type": "key", "target": "KEY_Q"},
            {"trigger": "l2", "type": "key", "target": "KEY_LEFTSHIFT"},
            {"trigger": "r2", "type": "key", "target": "KEY_LEFTMOUSE"},
            {"trigger": "l3", "type": "key", "target": "KEY_C"},
            {"trigger": "r3", "type": "key", "target": "KEY_V"},
            {"trigger": "start", "type": "key", "target": "KEY_ESC"},
            {"trigger": "select", "type": "key", "target": "KEY_I"},
            {"trigger": "pageup", "type": "key", "target": "KEY_1"},
            {"trigger": "pagedown", "type": "key", "target": "KEY_2"}
        ]
    }
}
RPG_MAPPING
  echo "/tmp/rpg_mapping.json"
}

create_racing_mapping() {
  cat > "/tmp/racing_mapping.json" << 'RACING_MAPPING'
{
    "name": "Racing - Driving Games",
    "description": "Optimized for racing games like Need for Speed, Forza, Burnout",
    "mapping": {
        "actions_player1": [
            {"trigger": "joystick1left", "type": "key", "target": "KEY_A"},
            {"trigger": "joystick1right", "type": "key", "target": "KEY_D"},
            {"trigger": "joystick1up", "type": "key", "target": "KEY_W"},
            {"trigger": "joystick1down", "type": "key", "target": "KEY_S"},
            {"trigger": "a", "type": "key", "target": "KEY_SPACE"},
            {"trigger": "b", "type": "key", "target": "KEY_LEFTSHIFT"},
            {"trigger": "x", "type": "key", "target": "KEY_R"},
            {"trigger": "y", "type": "key", "target": "KEY_E"},
            {"trigger": "l1", "type": "key", "target": "KEY_Q"},
            {"trigger": "r1", "type": "key", "target": "KEY_E"},
            {"trigger": "l2", "type": "key", "target": "KEY_A"},
            {"trigger": "r2", "type": "key", "target": "KEY_D"},
            {"trigger": "start", "type": "key", "target": "KEY_ESC"},
            {"trigger": "select", "type": "key", "target": "KEY_TAB"},
            {"trigger": "pageup", "type": "key", "target": "KEY_1"},
            {"trigger": "pagedown", "type": "key", "target": "KEY_2"}
        ]
    }
}
RACING_MAPPING
  echo "/tmp/racing_mapping.json"
}

create_platformer_mapping() {
  cat > "/tmp/platformer_mapping.json" << 'PLATFORMER_MAPPING'
{
    "name": "Platformer - 2D/3D Platform Games",
    "description": "Optimized for platformers like Super Meat Boy, Celeste, Hollow Knight",
    "mapping": {
        "actions_player1": [
            {"trigger": "joystick1left", "type": "key", "target": "KEY_A"},
            {"trigger": "joystick1right", "type": "key", "target": "KEY_D"},
            {"trigger": "joystick1up", "type": "key", "target": "KEY_W"},
            {"trigger": "joystick1down", "type": "key", "target": "KEY_S"},
            {"trigger": "a", "type": "key", "target": "KEY_SPACE"},
            {"trigger": "b", "type": "key", "target": "KEY_LEFTSHIFT"},
            {"trigger": "x", "type": "key", "target": "KEY_E"},
            {"trigger": "y", "type": "key", "target": "KEY_F"},
            {"trigger": "l1", "type": "key", "target": "KEY_Q"},
            {"trigger": "r1", "type": "key", "target": "KEY_R"},
            {"trigger": "start", "type": "key", "target": "KEY_ESC"},
            {"trigger": "select", "type": "key", "target": "KEY_TAB"}
        ]
    }
}
PLATFORMER_MAPPING
  echo "/tmp/platformer_mapping.json"
}

create_fighting_mapping() {
  cat > "/tmp/fighting_mapping.json" << 'FIGHTING_MAPPING'
{
    "name": "Fighting - Combat Games", 
    "description": "Optimized for fighting games like Street Fighter, Mortal Kombat, Tekken",
    "mapping": {
        "actions_player1": [
            {"trigger": "joystick1left", "type": "key", "target": "KEY_A"},
            {"trigger": "joystick1right", "type": "key", "target": "KEY_D"},
            {"trigger": "joystick1up", "type": "key", "target": "KEY_W"},
            {"trigger": "joystick1down", "type": "key", "target": "KEY_S"},
            {"trigger": "a", "type": "key", "target": "KEY_J"},
            {"trigger": "b", "type": "key", "target": "KEY_K"},
            {"trigger": "x", "type": "key", "target": "KEY_U"},
            {"trigger": "y", "type": "key", "target": "KEY_I"},
            {"trigger": "l1", "type": "key", "target": "KEY_H"},
            {"trigger": "r1", "type": "key", "target": "KEY_L"},
            {"trigger": "l2", "type": "key", "target": "KEY_O"},
            {"trigger": "r2", "type": "key", "target": "KEY_P"},
            {"trigger": "start", "type": "key", "target": "KEY_ENTER"},
            {"trigger": "select", "type": "key", "target": "KEY_ESC"}
        ]
    }
}
FIGHTING_MAPPING
  echo "/tmp/fighting_mapping.json"
}

create_strategy_mapping() {
  cat > "/tmp/strategy_mapping.json" << 'STRATEGY_MAPPING'
{
    "name": "Strategy - RTS/TBS Games",
    "description": "Optimized for strategy games like StarCraft, Civilization, Age of Empires",
    "mapping": {
        "actions_player1": [
            {"trigger": "joystick1left", "type": "key", "target": "KEY_LEFT"},
            {"trigger": "joystick1right", "type": "key", "target": "KEY_RIGHT"},
            {"trigger": "joystick1up", "type": "key", "target": "KEY_UP"},
            {"trigger": "joystick1down", "type": "key", "target": "KEY_DOWN"},
            {"trigger": "joystick2left", "type": "key", "target": "KEY_A"},
            {"trigger": "joystick2right", "type": "key", "target": "KEY_D"},
            {"trigger": "joystick2up", "type": "key", "target": "KEY_W"},
            {"trigger": "joystick2down", "type": "key", "target": "KEY_S"},
            {"trigger": "a", "type": "key", "target": "KEY_ENTER"},
            {"trigger": "b", "type": "key", "target": "KEY_ESC"},
            {"trigger": "x", "type": "key", "target": "KEY_SPACE"},
            {"trigger": "y", "type": "key", "target": "KEY_TAB"},
            {"trigger": "l1", "type": "key", "target": "KEY_Q"},
            {"trigger": "r1", "type": "key", "target": "KEY_E"},
            {"trigger": "l2", "type": "key", "target": "KEY_1"},
            {"trigger": "r2", "type": "key", "target": "KEY_2"},
            {"trigger": "start", "type": "key", "target": "KEY_ESC"},
            {"trigger": "select", "type": "key", "target": "KEY_TAB"}
        ]
    }
}
STRATEGY_MAPPING
  echo "/tmp/strategy_mapping.json"
}

# ==========================================================
# FUNCTION: Create Windows Gamepad Mapping with Genre Selection
# ==========================================================
create_windows_gamepad_mapping() {
  while true; do
    # --- Find Wineprefixes ---
    mapfile -t wineprefixes < <(find_wineprefixes)
    
    if [ ${#wineprefixes[@]} -eq 0 ]; then
      dialog --msgbox "No Wine prefix directories found!" 10 40
      break
    fi

    # Build menu options
    prefix_options=()
    for prefix in "${wineprefixes[@]}"; do
      prefix_name=$(basename "$prefix")
      prefix_options+=("$prefix" "$prefix_name")
    done

    selected_prefix=$(dialog --clear --stdout --title "Select Wine Prefix" \
      --menu "Choose prefix for gamepad mapping:" \
      15 80 6 "${prefix_options[@]}")
    [ $? -ne 0 ] && break

    # --- Select Game Genre ---
    genre=$(dialog --clear --stdout --title "Select Game Genre" \
      --menu "Choose mapping profile:" 18 70 8 \
      "fps" "First Person Shooter (CoD, Battlefield, Halo)" \
      "rpg" "Role Playing Game (Skyrim, Witcher, Fallout)" \
      "racing" "Racing Games (Need for Speed, Forza)" \
      "platformer" "Platformer (Celeste, Hollow Knight)" \
      "fighting" "Fighting Games (Street Fighter, Tekken)" \
      "strategy" "Strategy Games (StarCraft, Civilization)" \
      "custom" "Select from custom profiles" \
      "universal" "Universal Default Mapping")
    
    [ $? -ne 0 ] && continue

    # Handle custom profiles
    if [ "$genre" = "custom" ]; then
      PROFILES_DIR="/userdata/system/djinncade-addons/terminal/gamepad-profiles"
      profiles=()
      while IFS= read -r -d '' profile; do
        profile_name=$(basename "$profile" .json)
        profiles+=("$profile_name" "")
      done < <(find "$PROFILES_DIR" -name "*.json" -type f -print0 2>/dev/null)
      
      if [ ${#profiles[@]} -eq 0 ]; then
        dialog --msgbox "No custom profiles found. Using universal default." 7 50
        genre="universal"
      else
        custom_profile=$(dialog --clear --stdout \
          --menu "Select custom profile:" 15 60 5 "${profiles[@]}")
        if [ -n "$custom_profile" ]; then
          profile_file="$PROFILES_DIR/${custom_profile}.json"
        else
          continue
        fi
      fi
    fi

    # Create the appropriate mapping
    case $genre in
      "fps")
        create_fps_mapping > /dev/null
        profile_file="/tmp/fps_mapping.json"
        profile_name="FPS Shooter Profile"
        ;;
      "rpg")
        create_rpg_mapping > /dev/null
        profile_file="/tmp/rpg_mapping.json"
        profile_name="RPG Profile" 
        ;;
      "racing")
        create_racing_mapping > /dev/null
        profile_file="/tmp/racing_mapping.json"
        profile_name="Racing Profile"
        ;;
      "platformer")
        create_platformer_mapping > /dev/null
        profile_file="/tmp/platformer_mapping.json"
        profile_name="Platformer Profile"
        ;;
      "fighting")
        create_fighting_mapping > /dev/null
        profile_file="/tmp/fighting_mapping.json"
        profile_name="Fighting Profile"
        ;;
      "strategy")
        create_strategy_mapping > /dev/null
        profile_file="/tmp/strategy_mapping.json"
        profile_name="Strategy Profile"
        ;;
      "universal")
        create_universal_mapping > /dev/null
        profile_file="/tmp/universal_mapping.json"
        profile_name="Universal Profile"
        ;;
    esac

    # Create the actual padto.keys file
    padto_keys_file="$selected_prefix/padto.keys"
    
    if [ -f "$profile_file" ]; then
      # Extract just the mapping section for padto.keys
      if command -v jq >/dev/null 2>&1; then
        jq '.mapping' "$profile_file" > "$padto_keys_file"
      else
        # Fallback if jq not available - use the full file
        cp "$profile_file" "$padto_keys_file"
      fi
    else
      # Fallback to universal mapping
      create_universal_mapping > /dev/null
      cp "/tmp/universal_mapping.json" "$padto_keys_file"
    fi

    # Show mapping summary
    show_mapping_summary "$genre" "$profile_name"

    dialog --msgbox "✅ Gamepad mapping created!\n\nProfile: $profile_name\nLocation: $padto_keys_file\n\nGamepad controls are now optimized for $genre games." 12 70

    dialog --yesno "Create mapping for another Wine prefix?" 7 50
    [ $? -ne 0 ] && break
  done
}

create_universal_mapping() {
  cat > "/tmp/universal_mapping.json" << 'UNIVERSAL_MAPPING'
{
    "name": "Universal - Default Mapping",
    "description": "General purpose mapping for various game types",
    "mapping": {
        "actions_player1": [
            {"trigger": "joystick1left", "type": "key", "target": "KEY_A"},
            {"trigger": "joystick1right", "type": "key", "target": "KEY_D"},
            {"trigger": "joystick1up", "type": "key", "target": "KEY_W"},
            {"trigger": "joystick1down", "type": "key", "target": "KEY_S"},
            {"trigger": "joystick2left", "type": "key", "target": "KEY_LEFT"},
            {"trigger": "joystick2right", "type": "key", "target": "KEY_RIGHT"},
            {"trigger": "joystick2up", "type": "key", "target": "KEY_UP"},
            {"trigger": "joystick2down", "type": "key", "target": "KEY_DOWN"},
            {"trigger": "a", "type": "key", "target": "KEY_SPACE"},
            {"trigger": "b", "type": "key", "target": "KEY_C"},
            {"trigger": "x", "type": "key", "target": "KEY_F"},
            {"trigger": "y", "type": "key", "target": "KEY_R"},
            {"trigger": "l1", "type": "key", "target": "KEY_Q"},
            {"trigger": "r1", "type": "key", "target": "KEY_E"},
            {"trigger": "l2", "type": "key", "target": "KEY_LEFTSHIFT"},
            {"trigger": "r2", "type": "key", "target": "KEY_LEFTMOUSE"},
            {"trigger": "l3", "type": "key", "target": "KEY_LEFTSHIFT"},
            {"trigger": "r3", "type": "key", "target": "KEY_V"},
            {"trigger": "start", "type": "key", "target": "KEY_ESC"},
            {"trigger": "select", "type": "key", "target": "KEY_TAB"},
            {"trigger": "pageup", "type": "key", "target": "KEY_1"},
            {"trigger": "pagedown", "type": "key", "target": "KEY_2"}
        ]
    }
}
UNIVERSAL_MAPPING
  echo "/tmp/universal_mapping.json"
}

show_mapping_summary() {
  local genre="$1"
  local profile_name="$2"
  
  case $genre in
    "fps")
      summary="🎯 FPS Profile:\n• Left Stick: WASD Movement\n• Right Stick: Arrow Keys Aim\n• A: Spacebar (Jump)\n• B: C (Crouch)\n• X: R (Reload)\n• Y: F (Interact)\n• L1: Q (Lean/Secondary)\n• R1: G (Grenade)\n• L2: Shift (Sprint)\n• R2: E (Use)\n• L3: Shift (Sprint)\n• R3: V (Melee)"
      ;;
    "rpg")
      summary="⚔️ RPG Profile:\n• Left Stick: WASD Movement\n• Right Stick: Arrow Keys Camera\n• A: Spacebar (Jump)\n• B: E (Interact)\n• X: R (Ready weapon)\n• Y: F (Favorites)\n• L1: Tab (Quick menu)\n• R1: Q (Shout/Power)\n• L2: Shift (Sprint)\n• R2: Left Click (Attack)\n• L3: C (Sneak)\n• R3: V (Wait)"
      ;;
    "racing")
      summary="🏎️ Racing Profile:\n• Left Stick: WASD Steering\n• A: Spacebar (Handbrake)\n• B: Shift (Nitrous/Boost)\n• X: R (Reset car)\n• Y: E (Change view)\n• L1: Q (Look left)\n• R1: E (Look right)\n• L2: A (Brake/Reverse)\n• R2: D (Accelerate)"
      ;;
    "platformer")
      summary="🦔 Platformer Profile:\n• Left Stick: WASD Movement\n• A: Spacebar (Jump)\n• B: Shift (Run/Dash)\n• X: E (Interact)\n• Y: F (Attack)\n• L1: Q (Special 1)\n• R1: R (Special 2)"
      ;;
    "fighting")
      summary="🥊 Fighting Profile:\n• Left Stick: WASD Movement\n• A: J (Light Punch)\n• B: K (Medium Punch)\n• X: U (Light Kick)\n• Y: I (Medium Kick)\n• L1: H (Heavy Punch)\n• R1: L (Heavy Kick)\n• L2: O (Special 1)\n• R2: P (Special 2)"
      ;;
    "strategy")
      summary="♟️ Strategy Profile:\n• Left Stick: Arrow Keys (Map scroll)\n• Right Stick: WASD (Camera)\n• A: Enter (Select/Confirm)\n• B: ESC (Cancel)\n• X: Spacebar (Pause)\n• Y: Tab (Menu)\n• L1: Q (Quick command 1)\n• R1: E (Quick command 2)\n• L2: 1 (Control group 1)\n• R2: 2 (Control group 2)"
      ;;
    *)
      summary="🔄 Universal Profile:\n• Left Stick: WASD Movement\n• Right Stick: Arrow Keys Camera\n• A: Spacebar (Jump/Accept)\n• B: C (Crouch/Cancel)\n• X: F (Interact)\n• Y: R (Reload/Ready)\n• L1: Q (Secondary)\n• R1: E (Use)\n• L2: Shift (Sprint)\n• R2: Left Click (Attack)\n• Start: ESC (Menu)\n• Select: TAB (Inventory)"
      ;;
  esac
  
  dialog --title "🎮 $profile_name" --msgbox "$summary" 18 70
}
EOF

# Module: Basic Commands - FIXED: Removed wine/network/keyboard from main commands
cat > "$MODULES_DIR/module-basic.sh" <<'EOF'
#!/bin/bash
# Module: Basic Djinn Commands

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

djinn-help() {
  require_enabled_or_die "djinn-help" || return 1
  msg=$'Visible Commands:\n\nsummon-djinn\nbanish-djinn\ndjinn-style\ndjinn-cheats\ndjinn-help\n'
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

djinn-king() {
  require_enabled_or_die "djinn-king" || return 1
  ensure_king_state
  read_enabled_commands
  all_cmds=(summon-djinn banish-djinn djinn-style djinn-cheats djinn-play djinn-king zynn djinn-help djinn-what)
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
  
  echo "# enabled commands" > "$BASE_DIR/.djinn-king-state.conf"
  for s in $SELECT; do 
    s=$(echo "$s" | tr -d '"')
    echo -n "$s " >> "$BASE_DIR/.djinn-king-state.conf"
  done
  echo "" >> "$BASE_DIR/.djinn-king-state.conf"
  
  if ! grep -qw "zynn" "$BASE_DIR/.djinn-king-state.conf" 2>/dev/null; then 
    rm -f "$BASE_DIR/.zynn.config" 2>/dev/null || true
  else
    [ -f "$BASE_DIR/.zynn.config" ] || echo "LAST_DIR=/userdata" > "$BASE_DIR/.zynn.config"
  fi
  
  if grep -qw "summon-djinn" "$BASE_DIR/.djinn-king-state.conf" 2>/dev/null; then 
    dialog --clear --msgbox "👑 The Djinn now walks among mortals." 6 50
  else 
    dialog --clear --msgbox "👑 The Djinn now slumbers in the shadows." 6 50
  fi
  
  clear
  show_banner
}

zynn() {
  require_enabled_or_die "zynn" || return 1
  if [ -f "$BASE_DIR/.zynn.config" ]; then . "$BASE_DIR/.zynn.config" 2>/dev/null || true; fi
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
      F:*) fname="${SEL#F:}"; fp="$current_dir/$fname"; dialog --clear --msgbox "🎬 Playing: $fname\nPress OK to stop." 6 50; echo "LAST_DIR=$current_dir" > "$BASE_DIR/.zynn.config"; mpv --fs "$fp" 2>/dev/null || true ;;
      *) continue ;;
    esac
  done
  clear
  show_banner
}
EOF

# -----------------------------
# Create Main Loader
# -----------------------------
cat > "$BASE_DIR/custom.sh" <<'EOF'
#!/bin/bash
# Djinn Terminal v16 - Modular Loader With Enhanced Wine Tools
# Main file that loads all cores and modules

# Only for interactive shells
[[ $- != *i* ]] && return

# Set base paths
BASE_DIR="/userdata/system/djinncade-addons/terminal"
MODULES_DIR="$BASE_DIR/modules"
CORES_DIR="$BASE_DIR/cores"

# Source configuration first
if [ -f "$BASE_DIR/djinn-config.conf" ]; then
    source "$BASE_DIR/djinn-config.conf"
fi

# Load core libraries
for core_file in "$CORES_DIR"/*.sh; do
    if [ -f "$core_file" ]; then
        source "$core_file"
    fi
done

# Load module functions
for module_file in "$MODULES_DIR"/*.sh; do
    if [ -f "$module_file" ]; then
        source "$module_file"
    fi
done

# Export all functions
export -f summon-djinn banish-djinn djinn-help djinn-what djinn-style djinn-cheats djinn-play djinn-king zynn auto-wine-tools network-tools keyboard-setup 2>/dev/null || true

# Initialize
apply_dialog_from_config
load_style_and_build_ps1
show_banner
EOF

chmod +x "$BASE_DIR/custom.sh"

# -----------------------------
# Create Uninstaller
# -----------------------------
cat > "$BASE_DIR/djinncade-uninstall.sh" <<'EOF'
#!/bin/bash
# Modular Djinn Uninstaller
set -euo pipefail

BASE_DIR="/userdata/system/djinncade-addons/terminal"
BASHRC="$HOME/.bashrc"

dialog --clear --backtitle "🧞 Djinn Uninstaller" --yesno "Remove Djinn Terminal?" 10 60
[ $? -ne 0 ] && exit 0

# Remove from .bashrc
if [ -f "$BASHRC" ]; then
    sed -i "\|source $BASE_DIR/custom.sh|d" "$BASHRC"
fi

# Remove directory
rm -rf "$BASE_DIR"

dialog --clear --msgbox "Djinn Terminal removed completely." 7 50
clear
echo "Uninstallation complete."
EOF

chmod +x "$BASE_DIR/djinncade-uninstall.sh"

# -----------------------------
# Create King State - FIXED: Hidden files
# -----------------------------
cat > "$BASE_DIR/.djinn-king-state.conf" <<EOF
# enabled commands (space-separated)
summon-djinn banish-djinn djinn-style djinn-cheats djinn-play djinn-king zynn djinn-help djinn-what
EOF

# -----------------------------
# Update .bashrc
# -----------------------------
BASHRC="$HOME/.bashrc"
if [ -f "$BASHRC" ]; then
    if ! grep -qF "source $BASE_DIR/custom.sh" "$BASHRC"; then
        echo -e "\n# Djinn Terminal Modular v16\nif [ -f \"$BASE_DIR/custom.sh\" ]; then source \"$BASE_DIR/custom.sh\"; fi" >> "$BASHRC"
    fi
else
    cat > "$BASHRC" <<BASHRC
# .bashrc created by Djinn Terminal
if [ -f "$BASE_DIR/custom.sh" ]; then source "$BASE_DIR/custom.sh"; fi
BASHRC
fi

# -----------------------------
# Set permissions
# -----------------------------
chmod +x "$CORES_DIR"/*.sh
chmod +x "$MODULES_DIR"/*.sh

# -----------------------------
# Finalize and Auto-Delete
# -----------------------------
log "Modular setup v16 completed successfully with Enhanced Wine Tools"
clear

cat <<FINAL
╔════════════════════════════════════════════════════════════════╗
🎉 Djinn Terminal V16 - With Enhanced Wine Tools Installed!

  Structure:
  ├── custom.sh (main loader)
  ├── cores/ (3 core libraries)
  │   ├── core-dialog.sh
  │   ├── core-permissions.sh  
  │   └── core-display.sh
  ├── modules/ (7 feature modules)
  │   ├── module-basic.sh
  │   ├── module-style.sh
  │   ├── module-cheats.sh ← UPDATED: Game type selection before file browser
  │   ├── module-network.sh
  │   ├── module-keyboard.sh
  │   ├── module-wine-tools.sh  ← ENHANCED WINE TOOLS!
  └── djinn-config.conf

  Hidden Files:
  🔒 /userdata/system/djinncade-addons/.dialogrc (custom theme)
  🔒 $BASE_DIR/.djinn-king-state.conf (command permissions)
  🔒 $BASE_DIR/.zynn.config (video player state)

  Ports Integration:
  ✅ /userdata/roms/ports/djinn-cheats.sh (Ports launcher)
  ✅ /userdata/roms/ports/djinn-cheats.sh.keys (Player 1 & 2 only)

  Main Commands Available:
  ✅ summon-djinn, banish-djinn
  ✅ djinn-style (FIXED - proper Save & Exit)
  ✅ djinn-cheats (IMPROVED - game type selection first)
  ✅ djinn-help, djinn-what, djinn-play, djinn-king
  ✅ zynn (video player)

  Cheats Menu Tools (NOT in main commands):
  🍷 Enhanced Auto Wine Tools (multi-genre gamepad mapping)
  🌐 Network Tools (Wi-Fi, speed test, ping)
  ⌨️ Keyboard Setup (layout & timezone)

  ENHANCED Wine Tools Features:
  🍷 Create autorun.cmd for automatic game launching
  🎮 Multi-controller auto-configuration for Wine prefixes
  🎮 Multi-genre gamepad mapping system:
    • FPS (Call of Duty, Battlefield, Halo)
    • RPG (Skyrim, Witcher, Fallout) 
    • Racing (Need for Speed, Forza)
    • Platformer (Celeste, Hollow Knight)
    • Fighting (Street Fighter, Tekken)
    • Strategy (StarCraft, Civilization)
  📁 Profile management for custom mappings
  🔧 Persistent controller mappings in Wine registry

  IMPROVED SquashFS Workflow:
  🎯 Game type selection BEFORE file browser
  📁 Auto-jumps to appropriate directory (Windows/PS3/Other)
  🗂️ Organized game management by platform
  ⚡ Faster navigation for game files

  FIXES:
  ⚡ Fast return after permission denied messages
  🚫 Wine/Network/Keyboard removed from main command toggle
  🎮 Only Player 1 & 2 gamepad support (cleaner config)
  🔒 All config files are now hidden
  🗑️ Auto-deletes setup script after installation

╚════════════════════════════════════════════════════════════════╝
FINAL

sleep 3

echo "✅ Modular setup complete! Open a new terminal or run: source $BASE_DIR/custom.sh"
echo "🎮 Djinn Cheats is now available in Ports menu with Player 1 & 2 gamepad support!"
echo "🍷 Enhanced Auto Wine Tools with multi-genre mapping available through djinn-cheats!"
echo "📁 Improved SquashFS workflow: Select game type BEFORE browsing files!"

# Auto-delete the setup script
SCRIPT_PATH="$(realpath "$0")"
echo "🧹 Cleaning up setup script..."
rm -f "$SCRIPT_PATH"
echo "✅ Setup script auto-deleted. Djinn Terminal V16 is ready!"

exit 0
