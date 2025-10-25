# 🧾 DjinnCade Changelog

A record of the Djinn's blessings, bug banishments, and terminal enchantments.  
Each version refines the art of command-line magic within Batocera. 🧞‍♂️  

---

## 🐉 V14.2 – *Wine Wizardry Edition* (2025-10-25)

> "The Djinn now speaks the language of Windows, crafting autorun spells for Wine realms."

### ✨ New Enchantments
- **🧩 Auto CMD Wine**: New command to create `autorun.cmd` files for Wineprefixes
  - Automatically detects Wineprefix directories in `/userdata/roms/windows/` and `/userdata/system/wine-bottles/windows/`
  - Smart path handling: writes `DIR=<subfolder>` only when executable is in subdirectory
  - Proper quoting for executables with spaces in filenames
  - Loop functionality to process multiple Wineprefixes in one session

### 🔧 Structural Refinements  
- **🧹 Purged Redundant Spells**: Removed move, copy, and delete functions from `djinn-cheats`
- **🧭 Path Perfection**: All file operations (zip/unzip/squashfs) now properly start in `/userdata` directory
- **📜 Command Scrolls Updated**: 
  - `djinn-cheats` menu reorganized with "Auto CMD Wine" as option 7
  - `KING_STATE` now includes `auto-cmd-wine` in enabled commands
  - Help messages updated to showcase the new Wine automation
  - Export list expanded to include the new function

### 🎯 Technical Incantations
- **File Operations Fixed**: zip/unzip/squashfs/unsquashfs now run from `/userdata` directory with proper relative paths
- **Dialog Flow Enhanced**: Consistent error handling and banner reloading across all commands
- **Path Construction**: Clean path handling with no double slashes or directory issues

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

### 🧞 The Journey Continues...
Each version brings the DjinnCade Terminal closer to perfection.  
Your wishes, feedback, and pull requests guide the next summoning. ✨

**Next Incantations Planned:**
- 🎮 Enhanced game launching and management
- 🔧 Advanced system tuning options  
- 🌐 Network and remote access utilities
- 📦 Plugin system for community spells

*May your commands be swift and your terminals magical!* 🔮
