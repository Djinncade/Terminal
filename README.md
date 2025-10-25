# 🧞 DjinnCade Terminal Setup V14.2

A single-file installer that brings the **DjinnCade Terminal Addon** to your Batocera system — complete with custom themes, dialog-based menus, backups, and a touch of magic. ✨  

This setup adds a custom DjinnCade-styled terminal experience, blending functionality and flair right inside Batocera.

---

## 🎮 What It Does

The **DjinnCade Terminal Addon** enhances Batocera's terminal with:

- 🧱 Interactive dialog-based menus  
- 🎨 Color themes and style customization  
- 💾 Safe backup and restore tools (SquashFS-based)  
- 📦 File tools (zip/unzip/squashfs compression)
- 🍷 Wine automation with autorun.cmd creation
- 💬 Custom PS1 prompt styling  
- ⚙️ System info display (uptime, version, storage)  
- 🔄 Themed installer and uninstaller system  
- 🧞 Built-in command shortcuts for quick access to every feature  

---

### 🎮 Custom Commands List

After installation, you'll have access to several DjinnCade commands that make managing and customizing Batocera faster and easier.  

| Command | Function |
|----------|-----------|
| `summon-djinn` | Switches your terminal prompt to **Djinn Mode** (🔮 symbol + alternate PS1 colors). |
| `banish-djinn` | Reverts the terminal back to normal mode. |
| `djinn-style` | Opens the **Style Selector** — customize PS1 colors, dialog themes, and overall terminal look. |
| `djinn-cheats` | Opens the **Cheats & Tools Menu** — includes backup/restore, zip/unzip, SquashFS handling, and system info utilities. |
| `auto-cmd-wine` | Automatically creates autorun.cmd files for Wineprefixes. |
| `djinn-help` | Displays the **DjinnCade Help Menu**, showing visible commands and quick usage tips. |

🪄 *Extra commands exist but are not listed here 😉.*

Everything runs from **one single script** — no extra dependencies needed besides `bash` and `dialog`.

---

## ⚙️ Installation

1. Copy or download the setup script anywhere on your Batocera system —  
   you can place it in `/userdata/`, `/share/`, or any other folder you like.

2. Open a terminal or connect via SSH, then make it executable:
   ```bash
   chmod +x djinncade-terminal-setup-V14.2.sh
   ```

3. Run the installer:
   ```bash
   ./djinncade-terminal-setup-V14.2.sh
   ```

The installer will automatically set up everything and remove itself when finished.
