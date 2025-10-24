# 🧞 DjinnCade Terminal Setup V14

A single-file installer that brings the **DjinnCade Terminal Addon** to your Batocera system — complete with custom themes, dialog-based menus, backups, and a touch of magic. ✨

---

## 🎮 What It Does
The **DjinnCade Terminal Addon** enhances Batocera’s command line with:
- Interactive dialog menus and color themes  
- Safe backup and restore options using SquashFS  
- File browsing, copy, and delete tools  
- Custom PS1 prompt styling  
- System info display (uptime, version, storage)  
- A themed installer/uninstaller system  

All packed inside one self-contained script — no external dependencies beyond `bash` and `dialog`.

---

## ⚙️ Installation

1. Download or copy the setup script anywhere on your Batocera system —  
   it can be in `/userdata/`, `/share/`, or any folder you like.

2. Open a terminal or connect via SSH, then make the script executable:
   ```bash
   chmod +x djinncade-terminal-setup-V14.sh
