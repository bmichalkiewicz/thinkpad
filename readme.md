<div align="center">

*Classic • Simple • Functional*

</div>

---

## **Preview**


---

## **What's Included**

This rice features a carefully curated collection of tools and configurations:

### **`./system_monitoring`**
- **btop** - Resource monitor with Gruvbox theming
- **cava** - Audio visualizer for aesthetics
- **fastfetch** - Clean system information display

### **`./window_management`** 
- **hypr** - Hyprland compositor configuration
- **waybar** - Status bar with custom modules
- **swaync** - Notification center with gruvbox theming
- **wlogout** - Logout menu
- **wofi** - Application launcher

### **`./applications`**
- **kitty** - Terminal emulator with Gruvbox colors
- **yazi** - File manager with vim-like keybindings
- **zathura** - PDF viewer

### **`./utilities`**
- **swappy** - Screenshot annotation tool
- **zshrc** - Shell configuration with aliases and theming
- **Wallpaper Switcher** - Shell script that changes the wallpaper

---

## **Installation**

### **Prerequisites**

**Drivers and fonts**
```bash
 # Install drivers
 sudo pacman -S mesa vulkan-intel sof-firmware tlp tlp-rdw acpi_call \
 linux-firmware-intel alsa-firmware alsa-utils bluetui brightnessctl

 sudo systemctl enable tlp.service && sudo systemctl start tlp.service

 sudo systemctl mask systemd-rfkill && sudo systemctl masksystemd-rfkill.socket

# Install Iosevka Nerd Fonts
yay -S ttf-iosevka-nerd ttf-iosevka-nerd-mono
```

**System packages:**
```bash
# Essential packages
sudo pacman -S hyprland waybar kitty wofi zsh hyprlock stow swaync

# Audio system (PipeWire)
sudo pacman -S pipewire pipewire-pulse wireplumber

# Additional tools
yay -S btop cava fastfetch swappy yazi zathura wlogout
```

### **Setup**
```bash
# Clone the repository
git clone https://github.com/bmichalkiewicz/thinkpad.git
cd thinkpad

# Backup existing configs (optional but recommended)
mkdir -p ~/.config/backup
cp -r ~/.config/{hypr,waybar,kitty,wofi,btop,cava,yazi,zathura} ~/.config/backup/ 2>/dev/null

# Create symlinks
stow .
```

### **Post-Installation**
```bash
# Restart Hyprland or reboot for full effect
```
---


<div align="center">

*Feel free to star ⭐ if you found this useful!*

</div>
