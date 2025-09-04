#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    print_error "This script is designed for Arch Linux systems with pacman package manager"
    exit 1
fi

print_status "Starting ThinkPad rice installation..."

# Install drivers and system components
print_status "Installing drivers and system components..."
sudo pacman -S --needed mesa vulkan-intel sof-firmware tlp tlp-rdw acpi_call \
    linux-firmware-intel alsa-firmware alsa-utils bluetui brightnessctl

# Enable and start TLP service
print_status "Enabling TLP power management..."
sudo systemctl enable tlp.service
sudo systemctl start tlp.service

# Mask conflicting services
print_status "Masking conflicting services..."
sudo systemctl mask systemd-rfkill
sudo systemctl mask systemd-rfkill.socket

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    print_warning "yay AUR helper not found. Installing yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# Install Iosevka Nerd Fonts
print_status "Installing Iosevka Nerd Fonts..."
yay -S --noconfirm ttf-iosevka-nerd ttf-iosevka-nerd-mono

# Install essential packages
print_status "Installing essential packages..."
sudo pacman -S --needed hyprland waybar kitty wofi zsh hyprlock stow swaync

# Install PipeWire audio system
print_status "Installing PipeWire audio system..."
sudo pacman -S --needed pipewire pipewire-pulse wireplumber

# Install additional tools via yay
print_status "Installing additional tools from AUR..."
yay -S --noconfirm btop cava fastfetch swappy yazi zathura wlogout

# Backup existing configs
print_status "Backing up existing configurations..."
mkdir -p ~/.config/backup
if cp -r ~/.config/{hypr,waybar,kitty,wofi,btop,cava,yazi,zathura} ~/.config/backup/ 2>/dev/null; then
    print_success "Existing configurations backed up to ~/.config/backup/"
else
    print_warning "No existing configurations found to backup"
fi

# Create symlinks using stow
print_status "Creating configuration symlinks..."
if command -v stow &> /dev/null; then
    stow .
    print_success "Configuration symlinks created successfully"
else
    print_error "GNU Stow not found. Please install stow and run 'stow .' manually"
    exit 1
fi

print_success "Installation completed successfully!"
print_status "Please restart Hyprland or reboot your system for full effect"
print_status "You may need to log out and select Hyprland as your session"

echo
print_status "To complete the setup:"
echo "  1. Log out of your current session"
echo "  2. Select 'Hyprland' from your display manager"
echo "  3. Enjoy your new rice! 🍚"