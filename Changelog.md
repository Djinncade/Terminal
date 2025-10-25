# 🧾 DjinnCade Changelog

A record of the Djinn's blessings, bug banishments, and terminal enchantments.  
Each version refines the art of command-line magic within Batocera. 🧞‍♂️  

---

## 🛡️ V14.4 – *File Safety Guardian Edition* (2025-10-27)

> "The Djinn now guards your files with watchful eyes, preventing accidental destruction while maintaining powerful file operations."

### 🛡️ **Safety Enchantments**
- **🛡️ File Overwrite Protection**: No more accidental folder destruction
  - **Smart Conflict Detection**: Shows exactly which files will be overwritten
  - **User Confirmation Required**: Always asks before replacing any files
  - **Targeted Operations**: Only specific files are replaced, never entire folders
  - **Clear Visual Feedback**: Users know exactly what's happening at each step

### 🔧 **Fixed File Operations**
- **📦 Zip Operations**: Now only overwrites the specific zip file, asks first
- **📤 Unzip Operations**: Detects file conflicts, shows list, confirms before overwriting
- **🗜️ SquashFS Creation**: Safe file replacement with user approval
- **📂 SquashFS Extraction**: Conflict detection and selective file overwriting

### ✨ **Enhanced User Experience**
- **🎯 Precise Control**: Users maintain complete control over file operations
- **🔍 Transparency**: See exactly what will change before it happens
- **🔄 Safe Recovery**: Accidental clicks no longer lead to data loss
- **📋 Conflict Lists**: View which specific files will be affected

---

## 🐉 V14.3 – *Network & Keyboard Mastery Edition* (2025-10-26)

> "The Djinn now commands the airwaves and types in every tongue, bringing network diagnostics and keyboard configuration to your fingertips."

### ✨ New Enchantments
- **🌐 Network Tools**: Comprehensive network diagnostics command
  - Wi-Fi status and signal quality monitoring
  - Network interface information display
  - Internet speed test with 100MB download and MB/s calculation
  - Ping testing with customizable targets
  - Available network scanning capabilities

- **⌨️ Keyboard Setup**: Regional and layout configuration
  - Keyboard layout selection (40+ languages supported)
  - Timezone/region configuration by city
  - Current settings display and validation
  - Batocera-compatible configuration handling

### 🔧 Enhanced Spells
- **🧹 File Operation Purification**: All file operations now strictly run from `/userdata` directory
  - Fixed zip/unzip path handling with proper relative paths
  - SquashFS creation/extraction now uses correct working directory
  - Eliminated potential path confusion in file browser

- **🎯 Dialog Flow Mastery**: Consistent clearing and banner restoration across all commands
  - Proper dialog cleanup after every operation
  - Unified error handling and user experience
  - Smooth transitions between menu levels

### 📜 Command Scrolls Updated
- `djinn-cheats` menu expanded with Network Tools (option 8) and Keyboard Setup (option 9)
- `KING_STATE` includes new `network-tools` and `keyboard-setup` commands
- Help system updated to showcase new capabilities
- Export lists expanded for all new functions

---

## 🐉 V14.2 – *Wine Wizardry Edition* (2025-10-25)

> "The Djinn now speaks the language of Windows, crafting autorun spells for Wine realms."

### ✨ New Enchantments
- **🧩 Auto CMD Wine**: Intelligent `autorun.cmd` creation for Wineprefixes
  - Automatically detects Wineprefix directories in `/userdata/roms/windows/` and `/userdata/system/wine-bottles/windows/`
  - Smart path handling with conditional `DIR=` statements
  - Proper quoting for executables with spaces in filenames
  - Batch processing for multiple Wineprefixes

### 🔧 Structural Refinements  
- **🧹 Purged Redundant Spells**: Removed move, copy, and delete functions from `djinn-cheats`
- **📜 Command Scrolls Updated**: 
  - `djinn-cheats` menu reorganized with "Auto CMD Wine" as option 7
  - `KING_STATE` includes `auto-cmd-wine` in enabled commands
  - Export list expanded for Wine automation function

---

## 🐉 V14.1 – *Beast Edition* (2025-10-24)

> "When the Beast awakens, the terminal roars with power."

- 🧹 Refined uninstall rituals for a cleaner exit  
- 🎨 Enhanced theme selector — no more color chaos  
- ⚡ Streamlined dialog flow and improved responsiveness  
- 🧠 Polished internal logic and error handling  
- 🧾 Prepared for future modular expansion  

---

## 🔮 V14 – *The Summoning* (2025-10-10)

> "The first spark of the DjinnCade Terminal — the wish was granted."

- 🌟 Initial public release  
- 🧭 Interactive terminal menus and theme system  
- 💾 Backup and restore functionality  
- 🧠 System info, file tools, and prompts  
- 🧞 Fully contained within `/userdata/system/djinncade-addons/terminal/`

---

## 🎯 **Technical Achievements (V14.4)**

### 🛡️ **Safety Features**
- **No More Accidental Overwrites**: File operations only replace specific target files
- **Conflict Detection**: Shows users exactly what will be overwritten
- **Mandatory Confirmation**: Always asks before overwriting anything
- **Clear Visual Feedback**: Users know exactly what's happening

### 🔧 **File Operation Security**
- **Zip Safety**: Only overwrites the specific zip file after confirmation
- **Unzip Intelligence**: Detects file conflicts and shows affected files
- **SquashFS Protection**: Safe creation and extraction with user approval
- **Targeted Operations**: Never wipes entire folders accidentally

### 🌐 **Network & International**
- **Network Diagnostics**: Complete Wi-Fi and connectivity analysis
- **International Support**: 40+ keyboard layouts and global timezones  
- **Path Safety**: All file operations secured to `/userdata` directory
- **Performance**: Optimized speed testing with proper MB/s calculations

---

### 🧞 **The Journey Continues...**
Each version brings the DjinnCade Terminal closer to perfection.  
Your wishes, feedback, and pull requests guide the next summoning. ✨

**Next Incantations Planned:**
- 🎮 **Controller Configuration Helper** - Advanced input mapping and profiles
- 🔧 **System Performance Suite** - Real-time monitoring and optimization
- 🌐 **Remote Access Tools** - SSH and network management
- 📦 **Plugin Architecture** - Community spell contributions
- 🗂️ **Advanced File Management** - Batch operations and smart organization

**Known Limitations:**
- Some network operations may require additional permissions
- Timezone changes might need Batocera system-level configuration
- Wi-Fi scanning depends on available wireless tools

### 🛡️ **Safety Philosophy**
> *"The Djinn believes in powerful magic, but never at the cost of your precious files. Every operation is guarded, every change is confirmed, and your data remains safe under our watchful protection."*

*May your commands be swift, your files be safe, and your terminals magical!* 🔮🛡️✨
