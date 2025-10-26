# 🧞 **DjinnCade Terminal — V15**

---

## ⚙️ **Overview**

Modular terminal system for Batocera with complete Ports integration:

* **Modular architecture** - Core libraries and feature modules
* **Complete theming system** - 8 dialog themes + PS1 customization  
* **Network diagnostics** - Wi-Fi, speed tests, ping utilities
* **Keyboard & region setup** - 40+ layouts with timezone support
* **Wine integration** - Auto Wineprefix detection & autorun.cmd creation
* **Safe file operations** - Backup, restore, zip, SquashFS with conflict detection
* **Ports menu integration** - Full gamepad support with custom styling

---

## ⚡ **Installation**

```bash
chmod +x djinn-modular-setup.sh
./djinn-modular-setup.sh
```

**Auto-loads on terminal start** - No manual sourcing required after installation

---

## 🗂️ **System Structure**

```
/userdata/system/djinncade-addons/terminal/
├── custom.sh              # Main loader
├── djinncade-uninstall.sh # Clean removal
├── cores/                 # Core libraries
│   ├── core-dialog.sh     # UI & theming
│   ├── core-permissions.sh # Command system
│   └── core-display.sh    # PS1 & banners
└── modules/               # Feature modules
    ├── module-basic.sh    # Core commands
    ├── module-style.sh    # PS1 & dialog themes
    ├── module-cheats.sh   # File operations
    ├── module-network.sh  # Network tools
    ├── module-keyboard.sh # Layout & timezone
    └── module-wine.sh     # Wine autorun setup

/userdata/roms/ports/
├── djinn-cheats.sh        # Ports launcher
└── djinn-cheats.sh.keys   # 8-player gamepad config

/userdata/system/djinncade-add-ons/
└── .dialogrc              # Custom dialog styling
```

---

## 💻 **Available Commands**

| Command | Description |
|---------|-------------|
| `summon-djinn` | Enable Djinn-themed prompt |
| `banish-djinn` | Return to normal shell |
| `djinn-style` | PS1 & dialog theme selector |
| `djinn-cheats` | File operations & system tools |
| `djinn-help` | Show available commands |
| `djinn-what` | Show hidden/advanced commands |
| `djinn-play` | Launch random game from library |
| `djinn-king` | Enable/disable commands |
| `auto-cmd-wine` | Wine autorun.cmd creator |
| `network-tools` | Wi-Fi, speed test, diagnostics |
| `keyboard-setup` | Layout & timezone configuration |
| `zynn` | Video file browser & player |

---

## 🎮 **Ports Integration**

**Access via Batocera Ports Menu:**
- Full-screen terminal with custom dialog styling
- Complete gamepad support for all operations
- 8-player controller configuration
- Seamless return to EmulationStation

**Features in Ports mode:**
- All `djinn-cheats` functionality
- Gamepad navigation (d-pad, buttons, hotkeys)
- Hotkey+Start to exit (Alt+F4)
- Custom theme application

---

## 🎨 **Theme System**

**8 Dialog Themes:**
1. **Classic Terminal** - White/Black/Cyan
2. **Midnight Blue** - Blue/White/Cyan  
3. **Emerald Forest** - Green/Black/Yellow
4. **Inferno Red** - Red/Yellow/White
5. **Royal Purple** - Magenta/Cyan/White
6. **Solarized Dark** - Yellow/Blue/Cyan
7. **Matrix Green** - Green/Black/Green
8. **CRT Amber** - Yellow/Black/Red

**PS1 Customization:**
- Symbol, user, path, and text colors
- Live preview with `summon-djinn`
- Preset combinations or individual elements

---

## 🛠️ **Key Features**

### **File Operations** (`djinn-cheats`)
- Backup/Restore to external media (SquashFS)
- Zip creation and extraction
- SquashFS filesystem image handling
- Safe conflict detection and confirmation

### **Network Tools** (`network-tools`) 
- Wi-Fi status and network scanning
- Internet speed testing (100MB download)
- Interface information and ping diagnostics

### **System Configuration** (`keyboard-setup`)
- 40+ international keyboard layouts
- Timezone and region settings
- Batocera-compatible configuration

### **Wine Integration** (`auto-cmd-wine`)
- Automatic Wineprefix detection
- Executable file discovery (.exe, .bat, .com)
- Smart autorun.cmd generation

---

## 🚀 **Quick Start**

**In Terminal:**
```bash
djinn-style    # Customize appearance
djinn-cheats   # Access file tools
network-tools  # Run diagnostics
```

**In Batocera Ports Menu:**
- Select "Djinn Cheats" for full-screen experience
- Use gamepad for all navigation
- Hotkey+Start to exit

---

## 🧹 **Uninstallation**

```bash
/userdata/system/djinncade-addons/terminal/djinncade-uninstall.sh
```

**Removes:**
- All terminal commands and functions
- Ports menu integration files
- Configuration and theme files
- Complete cleanup with confirmation

---

**DjinnCade Terminal — Modular. Powerful. Refined.** 🧞‍♂️
