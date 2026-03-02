#!/bin/bash

# ============================================================================
#  Minimal & Clean - bspwm Desktop Environment Installer
#  Target: LMDE 7 (Linux Mint Debian Edition) on MacBook Pro 2015
# ============================================================================

set -e

# ── Colors for output ──────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}"
echo "  ┌─────────────────────────────────────────────────────┐"
echo "  │       Minimal & Clean - bspwm Desktop Environment   │"
echo "  │              Installer for LMDE 7                    │"
echo "  └─────────────────────────────────────────────────────┘"
echo -e "${NC}"

# ── Pre-flight checks ─────────────────────────────────────────────────────

if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}[ERROR]${NC} Do not run this script as root. It will use sudo when needed."
    exit 1
fi

echo -e "${CYAN}[INFO]${NC} Starting installation..."
echo ""

# ── Update package lists ──────────────────────────────────────────────────

echo -e "${YELLOW}[1/6]${NC} Updating package lists..."
sudo apt update -qq

# ── Install core packages ─────────────────────────────────────────────────

echo -e "${YELLOW}[2/6]${NC} Installing core packages..."

# Window manager and utilities
sudo apt install -y \
    bspwm \
    sxhkd \
    polybar \
    picom \
    rofi \
    dunst \
    alacritty \
    feh \
    neofetch \
    hsetroot \
    xdotool \
    xclip \
    scrot \
    brightnessctl \
    i3lock \
    thunar \
    lxappearance \
    pavucontrol \
    pulseaudio-utils \
    network-manager-gnome \
    papirus-icon-theme \
    xorg \
    xinit

echo -e "${GREEN}[OK]${NC} Core packages installed."

# ── Install fonts ─────────────────────────────────────────────────────────

echo -e "${YELLOW}[3/6]${NC} Installing fonts..."

sudo apt install -y \
    fonts-jetbrains-mono \
    fonts-font-awesome

# Create user font directory
mkdir -p "$HOME/.local/share/fonts"

# Refresh font cache
fc-cache -fv > /dev/null 2>&1

echo -e "${GREEN}[OK]${NC} Fonts installed."

# ── Copy configuration files ──────────────────────────────────────────────

echo -e "${YELLOW}[4/6]${NC} Copying configuration files..."

# Create config directories
mkdir -p "$HOME/.config/bspwm"
mkdir -p "$HOME/.config/sxhkd"
mkdir -p "$HOME/.config/polybar"
mkdir -p "$HOME/.config/picom"
mkdir -p "$HOME/.config/rofi"
mkdir -p "$HOME/.config/dunst"
mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.config/neofetch"

# Copy configs
cp "$SCRIPT_DIR/config/bspwm/bspwmrc"          "$HOME/.config/bspwm/bspwmrc"
cp "$SCRIPT_DIR/config/sxhkd/sxhkdrc"          "$HOME/.config/sxhkd/sxhkdrc"
cp "$SCRIPT_DIR/config/polybar/config.ini"      "$HOME/.config/polybar/config.ini"
cp "$SCRIPT_DIR/config/polybar/launch.sh"       "$HOME/.config/polybar/launch.sh"
cp "$SCRIPT_DIR/config/picom/picom.conf"        "$HOME/.config/picom/picom.conf"
cp "$SCRIPT_DIR/config/rofi/config.rasi"        "$HOME/.config/rofi/config.rasi"
cp "$SCRIPT_DIR/config/dunst/dunstrc"           "$HOME/.config/dunst/dunstrc"
cp "$SCRIPT_DIR/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
cp "$SCRIPT_DIR/config/neofetch/config.conf"    "$HOME/.config/neofetch/config.conf"

echo -e "${GREEN}[OK]${NC} Configuration files copied."

# ── Set permissions ────────────────────────────────────────────────────────

echo -e "${YELLOW}[5/6]${NC} Setting permissions..."

chmod +x "$HOME/.config/bspwm/bspwmrc"
chmod +x "$HOME/.config/polybar/launch.sh"

echo -e "${GREEN}[OK]${NC} Permissions set."

# ── Create supporting directories and files ────────────────────────────────

echo -e "${YELLOW}[6/6]${NC} Setting up supporting files..."

# Create Screenshots directory
mkdir -p "$HOME/Pictures/Screenshots"

# Create .xinitrc if it does not exist
if [ ! -f "$HOME/.xinitrc" ]; then
    cat > "$HOME/.xinitrc" << 'XINITRC'
#!/bin/sh

# Source .xprofile if it exists
[ -f "$HOME/.xprofile" ] && . "$HOME/.xprofile"

# Start bspwm
exec bspwm
XINITRC
    chmod +x "$HOME/.xinitrc"
    echo -e "${GREEN}[OK]${NC} Created ~/.xinitrc"
else
    echo -e "${YELLOW}[SKIP]${NC} ~/.xinitrc already exists. Add 'exec bspwm' manually if needed."
fi

# Create bspwm .desktop entry for display managers
sudo mkdir -p /usr/share/xsessions
if [ ! -f /usr/share/xsessions/bspwm.desktop ]; then
    sudo tee /usr/share/xsessions/bspwm.desktop > /dev/null << 'DESKTOP'
[Desktop Entry]
Name=bspwm
Comment=Binary Space Partitioning Window Manager
Exec=bspwm
Type=Application
DESKTOP
    echo -e "${GREEN}[OK]${NC} Created bspwm session entry."
fi

echo ""
echo -e "${GREEN}"
echo "  ┌─────────────────────────────────────────────────────┐"
echo "  │           Installation Complete!                     │"
echo "  │                                                      │"
echo "  │  To start bspwm:                                     │"
echo "  │    - From TTY:  startx                               │"
echo "  │    - From DM:   Select 'bspwm' at login screen       │"
echo "  │                                                      │"
echo "  │  Wallpaper:                                          │"
echo "  │    Place your wallpaper at:                           │"
echo "  │    ~/.config/bspwm/wallpaper.jpg (or .png)            │"
echo "  │                                                      │"
echo "  │  Key Bindings:                                       │"
echo "  │    super+Return     Terminal (Alacritty)              │"
echo "  │    super+d          App Launcher (Rofi)               │"
echo "  │    super+q          Close Window                      │"
echo "  │    super+shift+r    Restart bspwm                     │"
echo "  │                                                      │"
echo "  └─────────────────────────────────────────────────────┘"
echo -e "${NC}"
