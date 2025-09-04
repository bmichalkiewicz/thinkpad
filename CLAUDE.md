# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Architecture

This is a ThinkPad Hyprland rice repository that provides a complete desktop environment configuration for Arch Linux. It's designed as a "rice" - a customized Linux desktop setup with a cohesive theme and workflow.

### Key Components

- **`install.sh`**: Main installation script that sets up the entire rice environment
- **`.config/hypr/`**: Hyprland window manager configuration split into modular files
- **`.config/waybar/`**: Status bar configuration with custom modules  
- **`.config/kitty/`**: Terminal emulator configuration with Gruvbox theming
- **`.config/wofi/`**: Application launcher configuration
- **`wallpapers/`**: Collection of themed wallpapers
- **`readme.md`**: User-facing documentation with installation instructions

### Configuration Architecture

The Hyprland configuration uses a modular approach with separate files:
- **`hyprland.conf`**: Main config file that sources all other configs
- **`bind.conf`**: Keybinding definitions
- **`animation.conf`**: Animation settings
- **`looknfeel.conf`**: Window aesthetics and styling
- **`startup.conf`**: Applications that launch at boot
- **`env.conf`**: Environment variables
- **`input.conf`**: Input device configurations
- **`colors.conf`**: Color scheme definitions

## Common Commands

### Installation and Setup
```bash
# Full system rice installation (Arch Linux only)
./install.sh

# Manual symlink creation after installation
stow .

# Backup existing configs before installation
mkdir -p ~/.config/backup
cp -r ~/.config/{hypr,waybar,kitty,wofi,btop,cava,yazi,zathura} ~/.config/backup/
```

### Configuration Management  
```bash
# Reload Hyprland configuration
hyprctl reload

# Test Hyprland config syntax
hyprctl --help

# Check which applications are running
hyprctl clients
```

### Theme and Wallpaper Management
```bash
# The rice includes a wallpaper switcher script
# Location and usage should be checked in startup.conf or scripts directory

# Gruvbox theme is applied across all components
# Colors are defined in .config/hypr/colors.conf and gruvbox.conf
```

## Architecture Patterns

### Modular Configuration
Each application follows the same pattern:
- Configuration files in `.config/<app>/`
- Gruvbox color scheme consistency
- Integration with Hyprland ecosystem

### Installation Pattern
The installation script follows this approach:
- System dependency checks (Arch Linux + pacman)
- Driver and font installation
- Package installation via pacman and yay (AUR helper)  
- Configuration backup and symlink creation
- Service management (TLP power management, audio system)

### Theme Integration
All components share the Gruvbox theme:
- **Terminal**: Kitty with Gruvbox colors
- **System Monitor**: btop with Gruvbox theming
- **Status Bar**: Waybar with custom Gruvbox modules
- **Notifications**: swaync with Gruvbox styling
- **Window Manager**: Hyprland with Gruvbox-based colors

## Important Implementation Details

### Target System Requirements
- **OS**: Arch Linux (pacman package manager required)
- **Hardware**: Optimized for ThinkPad laptops
- **Display**: Configured for 1920x1080 @60Hz (eDP-1 monitor)
- **Audio**: PipeWire audio system

### Power Management Integration
- TLP service for laptop power optimization
- Brightness control via brightnessctl
- Bluetooth support through bluetui

### Package Dependencies
**System packages** (pacman): hyprland, waybar, kitty, wofi, zsh, hyprlock, hyprpaper, stow, swaync, slurp, grim, wl-clipboard
**AUR packages** (yay): btop, cava, fastfetch, swappy, yazi, zathura, wlogout
**Fonts**: ttf-iosevka-nerd, ttf-iosevka-nerd-mono

### Hyprland-Specific Features
- Monitor configuration for laptop display
- Workspace management
- Window rules for XWayland compatibility
- Custom keybindings for rice-specific applications
- Integration with screenshot tools (slurp, grim, swappy)
- Wayland clipboard support via wl-clipboard