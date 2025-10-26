# 🧾 **DjinnCade Changelog**

---

## 🏗️ **V15 — Modular Architecture Edition** *(Current)*

### **Core Architecture**
- **Complete modular rewrite** - All functionality split into core libraries and feature modules
- **Clean separation** - Core utilities (`cores/`) vs. feature modules (`modules/`)
- **Centralized loader** - `custom.sh` orchestrates all components
- **Enhanced maintainability** - One feature per file for easy debugging

### **New Directory Structure**
```
/userdata/system/djinncade-addons/terminal/
├── custom.sh (main loader)
├── cores/
│   ├── core-dialog.sh (UI & theming)
│   ├── core-permissions.sh (command system)  
│   └── core-display.sh (PS1 & banners)
└── modules/
    ├── module-basic.sh (core commands)
    ├── module-style.sh (PS1 & dialog themes)
    ├── module-cheats.sh (file operations)
    ├── module-network.sh (Wi-Fi, speed tests)
    ├── module-keyboard.sh (layout & timezone)
    └── module-wine.sh (autorun.cmd creator)
```

### **Ports Integration** 🎮
- **Full Ports launcher** - `djinn-cheats.sh` in Ports menu
- **Complete gamepad support** - 8-player `.keys` configuration
- **Custom dialog styling** - Uses `/userdata/system/djinncade-add-ons/.dialogrc`
- **Seamless EmulationStation integration**

### **Enhanced Features**
- **8 Complete Themes** - Classic Terminal to CRT Amber
- **Safe File Operations** - Conflict detection & confirmation dialogs
- **Network Diagnostics** - Wi-Fi status, speed tests, ping utilities
- **Keyboard Configuration** - 40+ layouts with region settings
- **Wine Integration** - Auto Wineprefix detection & autorun.cmd creation

### **Fixed Issues** ✅
- **Save & Exit functionality** - Proper config persistence in `djinn-style`
- **Command permissions** - Robust enable/disable system
- **File safety** - No accidental overwrites, all operations in `/userdata`
- **Clean exit behavior** - Proper return to EmulationStation from Ports

---

## 🛡️ **V14.4 — File Safety Guardian Edition** *(2025-10-27)*

### **Safety Improvements**
- File conflict detection before overwriting
- Confirmation dialogs for all destructive operations
- File-level replacements only (no folder wipes)
- Safe zip/unzip and SquashFS operations
- All file actions confined to `/userdata` directory

---

## 🐉 **V14.3 — Network & Keyboard Edition** *(2025-10-26)*

### **Network Tools**
- Wi-Fi status and interface information
- Network scanning and signal strength
- Internet speed testing (100MB download metrics)
- Ping diagnostics and connectivity testing

### **Keyboard Setup**
- 40+ international keyboard layouts
- Timezone and region configuration
- Batocera-compatible settings application
- Current settings display and preview

---

## 🪄 **V14.2 — Wine Wizardry Edition** *(2025-10-25)*

### **Wine Integration**
- Automatic Wineprefix detection in multiple locations
- Executable file discovery (.exe, .bat, .com)
- Smart autorun.cmd generation with path handling
- Safe directory navigation and selection

---

## 🐉 **V14.1 — Beast Edition** *(2025-10-24)*

### **System Improvements**
- Clean uninstall process with confirmation
- Enhanced theme selector with previews
- Better error handling and user feedback
- Performance optimizations throughout

---

## 🔮 **V14 — The Summoning** *(2025-10-10)*

### **Initial Release**
- Interactive dialog-based menus
- Custom theme system with color presets
- Backup and restore functionality
- System information and monitoring tools
- Basic file operations and utilities

---

## 🚀 **Technical Specifications**

### **Command System**
- **12 Core Commands**: `summon-djinn` to `keyboard-setup`
- **Permission Management**: Enable/disable via `djinn-king`
- **Function Export**: All commands available in shell
- **Modular Loading**: Dynamic function availability

### **Theme System**
- **8 Dialog Themes**: Classic Terminal, Midnight Blue, Emerald Forest, Inferno Red, Royal Purple, Solarized Dark, Matrix Green, CRT Amber
- **PS1 Customization**: Symbol, user, path, and text colors
- **Live Preview**: Instant theme application

### **File Operations**
- **Backup/Restore**: SquashFS compression to external media
- **Archive Tools**: Zip creation and extraction
- **SquashFS**: Filesystem image creation and mounting
- **Safe Operations**: All actions require confirmation

---

## 🧞 **Future Roadmap**

### **Planned Features**
- **Controller configuration** - Gamepad mapping tools
- **Performance monitoring** - System resource dashboards  
- **SSH & remote management** - Network administration
- **Plugin support** - Extensible module system
- **Batch file tools** - Automated task processing
- **Dynamic module loader** - Runtime feature addition
- **System dashboard** - Comprehensive status overview

### **Enhancements**
- Additional theme packs and customization
- Expanded network diagnostics
- Enhanced Wine and Windows compatibility
- Mobile-friendly interface options
- Community plugin repository

---

**DjinnCade Terminal — Modular. Powerful. Refined.** 🧞‍♂️
