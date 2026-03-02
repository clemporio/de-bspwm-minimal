# Minimal & Clean - bspwm Desktop Environment

> A dark, minimal, and clean bspwm rice for LMDE 7 on MacBook Pro 2015.
> Inspired by r/unixporn [bspwm] posts.

![Screenshot Placeholder](screenshot.png)

---

## Overview

This dotfiles set provides a complete tiling window manager environment built around **bspwm**. The aesthetic is dark and minimal -- a Tokyo Night-inspired color palette with charcoal backgrounds, subtle window borders, generous gaps, and clean sans-serif typography.

### Components

| Component        | Software      | Purpose                    |
|------------------|---------------|----------------------------|
| Window Manager   | bspwm         | Tiling window management   |
| Hotkey Daemon    | sxhkd         | Keyboard shortcuts         |
| Status Bar       | Polybar       | System info & workspaces   |
| Compositor       | picom         | Shadows, blur, rounded corners |
| App Launcher     | Rofi          | Application launcher       |
| Notifications    | Dunst         | Desktop notifications      |
| Terminal         | Alacritty     | GPU-accelerated terminal   |
| Wallpaper        | feh/hsetroot  | Background wallpaper       |
| System Info      | Neofetch      | System information display |

---

## Color Palette

| Name       | Hex       | Preview |
|------------|-----------|---------|
| Background | `#1a1b26` |         |
| Foreground | `#c0caf5` |         |
| Black      | `#15161e` |         |
| Red        | `#f7768e` |         |
| Green      | `#9ece6a` |         |
| Yellow     | `#e0af68` |         |
| Blue       | `#7aa2f7` |         |
| Magenta    | `#bb9af7` |         |
| Cyan       | `#7dcfff` |         |
| White      | `#a9b1d6` |         |

---

## Installation

### Prerequisites

- LMDE 7 (Linux Mint Debian Edition) or any Debian-based distro
- A user account with sudo privileges
- Internet connection for package downloads

### Quick Install

```bash
git clone <this-repo> ~/dotfiles
cd ~/dotfiles/DE1-bspwm-minimal
chmod +x install.sh
./install.sh
```

### Manual Install

1. Install the packages listed below.
2. Copy the contents of `config/` to `~/.config/`.
3. Make `~/.config/bspwm/bspwmrc` and `~/.config/polybar/launch.sh` executable.
4. Log out and select **bspwm** from your display manager, or run `startx` from a TTY.

---

## Package List

### Core

```
bspwm sxhkd polybar picom rofi dunst alacritty feh neofetch
```

### Utilities

```
hsetroot xdotool xclip scrot brightnessctl i3lock
thunar lxappearance pavucontrol pulseaudio-utils
network-manager-gnome papirus-icon-theme xorg xinit
```

### Fonts

```
fonts-jetbrains-mono fonts-font-awesome
```

---

## Key Bindings Reference

### Applications

| Binding              | Action                      |
|----------------------|-----------------------------|
| `super + Return`     | Open terminal (Alacritty)   |
| `super + d`          | Open app launcher (Rofi)    |
| `super + e`          | Open file manager (Thunar)  |
| `super + b`          | Open web browser (Firefox)  |

### Window Management

| Binding                    | Action                          |
|----------------------------|---------------------------------|
| `super + q`                | Close focused window            |
| `super + shift + q`        | Kill focused window             |
| `super + f`                | Toggle fullscreen               |
| `super + space`            | Toggle floating                 |
| `super + t`                | Set tiled                       |
| `super + m`                | Toggle monocle layout           |

### Focus & Movement

| Binding                    | Action                          |
|----------------------------|---------------------------------|
| `super + {h,j,k,l}`       | Focus window (west/south/north/east) |
| `super + shift + {h,j,k,l}` | Swap window (west/south/north/east) |
| `super + alt + {h,j,k,l}` | Expand window in direction      |

### Workspaces

| Binding                    | Action                          |
|----------------------------|---------------------------------|
| `super + {1-5}`            | Switch to workspace 1-5         |
| `super + shift + {1-5}`    | Move window to workspace 1-5    |
| `super + [ / ]`            | Previous / next workspace       |

### System

| Binding                    | Action                          |
|----------------------------|---------------------------------|
| `super + shift + r`        | Restart bspwm                   |
| `super + Escape`           | Reload sxhkd config             |
| `super + shift + x`        | Lock screen                     |
| `Print`                    | Screenshot (full)               |
| `shift + Print`            | Screenshot (selection)          |
| `XF86AudioRaiseVolume`     | Volume up                       |
| `XF86AudioLowerVolume`     | Volume down                     |
| `XF86AudioMute`            | Toggle mute                     |
| `XF86MonBrightnessUp`      | Brightness up                   |
| `XF86MonBrightnessDown`    | Brightness down                 |

---

## Wallpaper

Place your wallpaper file at one of these paths:

```
~/.config/bspwm/wallpaper.jpg
~/.config/bspwm/wallpaper.png
```

If no wallpaper is found, the background defaults to solid `#1a1b26`.

For dark minimal wallpapers, search for "dark minimal wallpaper 2560x1600" or visit:
- [Unsplash - Dark Minimal](https://unsplash.com/s/photos/dark-minimal)
- [Wallhaven - Minimalist](https://wallhaven.cc/search?q=minimalist&categories=100&purity=100&sorting=favorites&order=desc)

---

## File Structure

```
~/.config/
  bspwm/bspwmrc           Window manager configuration
  sxhkd/sxhkdrc           Keybinding definitions
  polybar/config.ini       Status bar configuration
  polybar/launch.sh        Polybar launch script
  picom/picom.conf         Compositor settings
  rofi/config.rasi         Application launcher theme
  dunst/dunstrc            Notification daemon settings
  alacritty/alacritty.toml Terminal emulator settings
  neofetch/config.conf     System info display settings
```

---

## MacBook Pro 2015 Notes

- **Brightness keys** (`XF86MonBrightnessUp/Down`) are mapped via sxhkd using `brightnessctl`.
- **Volume keys** are mapped using PulseAudio's `pactl`.
- The battery module in Polybar uses `BAT0` / `ADP1` -- verify with `ls /sys/class/power_supply/` and adjust `config.ini` if your identifiers differ.
- For Wi-Fi, the Polybar wlan module auto-detects the wireless interface. If it does not appear, set `interface = wlp3s0` (or your interface name) explicitly in `config.ini`.

---

## Customization

### Changing Colors

All configuration files use the same color palette. To change the scheme, update the hex values in:
- `bspwmrc` (border colors)
- `polybar/config.ini` (bar colors)
- `picom/picom.conf` (no colors, but opacity/blur affect feel)
- `rofi/config.rasi` (launcher theme)
- `dunst/dunstrc` (notification colors)
- `alacritty/alacritty.toml` (terminal colors)

### Adjusting Gaps & Borders

In `bspwmrc`:
```sh
bspc config border_width  2    # Border thickness in pixels
bspc config window_gap    12   # Gap between windows in pixels
```

### Changing Fonts

The default font is **JetBrains Mono** at size 10-11. To change it, update:
- `polybar/config.ini` (font-0 line)
- `rofi/config.rasi` (font property)
- `dunst/dunstrc` (font setting)
- `alacritty/alacritty.toml` (font.normal.family)

---

## Credits & Inspiration

- [r/unixporn](https://www.reddit.com/r/unixporn/) community
- [Tokyo Night](https://github.com/enkia/tokyo-night-vscode-theme) color scheme by enkia
- [bspwm](https://github.com/baskerville/bspwm) by baskerville
- [Polybar](https://github.com/polybar/polybar)
- [picom](https://github.com/yshui/picom)
- [Rofi](https://github.com/davatorium/rofi)
- [Alacritty](https://github.com/alacritty/alacritty)
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
- [Papirus Icon Theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
