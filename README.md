# Nix Configuration

A comprehensive Nix configuration for managing multiple machines with a unified approach. This repository contains configurations for macOS (Darwin) and Linux systems, with shared home-manager configurations and custom packages.

## Overview

This repository manages the following machines:
- **meili** - macOS laptop (aarch64-darwin)
- **modgud** - Linux server (x86_64-linux)

Each machine has its own system configuration and home-manager setup, with shared modules and features.

## Project Structure

```
.
├── flake.nix              # Main flake configuration
├── hosts/                 # System-specific configurations
│   ├── meili/             # macOS laptop configuration
│   └── modgud/            # Linux server configuration
├── home/                  # My home-manager configurations
│   └── features/          # Shared home-manager features
│       ├── cli/           # CLI tools (git, fish, tmux, etc.)
│       ├── desktop/       # Desktop applications (aerospace, ghostty, etc.)
│       └── nvim/          # Neovim configuration
├── modules/               # Shared NixOS/Darwin modules
├── packages/              # Custom packages
├── lib/                   # Helper functions
└── overlays/              # Nixpkgs overlays
```

## Quick Start

### For macOS (meili)
```bash
# Apply system configuration
nix run github:lnl7/nix-darwin -- switch --flake .#meili

# Apply home-manager configuration
nix run github:nix-community/home-manager -- switch --flake .#thomas@meili
```

### For Linux (modgud)
```bash
# Apply system configuration (if NixOS)
nix run github:nix-community/nixos-anywhere -- --flake .#modgud root@modgud.t5.st

# Apply home-manager configuration
nix run github:nix-community/home-manager -- switch --flake .#thomas@modgud
```

## Features

### Shared CLI Tools
- **Fish shell** - Interactive shell with completions
- **Git** - Version control with custom configuration
- **TMUX** - Terminal multiplexer with custom keybindings
- **Starship** - Cross-shell prompt
- **Bat** - Better cat with syntax highlighting
- **SSH** - Secure shell configuration
- **GnuPG** - Encryption and signing

### Desktop Features (macOS only)
- **AeroSpace** - i3-style tiling window manager
- **Ghostty** - Modern terminal emulator
- **Zen Browser** - Privacy-focused browser
- **YubiKey** - Hardware security key support
- **Fonts** - Custom font configuration

### Development Tools
- **Neovim** - Text editor with LSP, treesitter, and telescope
- **Custom packages** - Including photo-cli for photo management

## Custom Packages

This repository includes several custom packages:

- `photo-cli` - Photo management and organization tool
- `tmux-select-pane-no-wrap` - TMUX pane selection without wrapping
- `aerospace-tmux-focus` - Integration between AeroSpace and TMUX
- `hello` - Example package

## Machine-Specific Configurations

### meili (macOS Laptop)
- **System**: aarch64-darwin
- **Features**: Full desktop environment with tiling window manager
- **Location**: America/Los_Angeles timezone
- **Services**: Remote login enabled

### modgud (Linux Server)
- **System**: x86_64-linux
- **Features**: Server-focused configuration with minimal desktop components
- **Location**: Europe/Amsterdam timezone
- **Services**: Reverse proxy, identity provider, P2P mesh network

## Development

### Adding a New Machine

1. Create a new directory in `hosts/` for your machine
2. Add system configuration to `flake.nix`
3. Create home-manager configuration in `home/`
4. Add any machine-specific modules as needed

### Adding New Features

1. Create feature modules in `home/features/`
2. Import them in the appropriate machine configurations
3. Update documentation as needed

## Notes

- The configuration uses Nix flake inputs for reproducible builds
- Home-manager configurations are shared between machines where appropriate
- Custom packages are defined in the `packages/` directory
- The `lib/` directory contains helper functions for creating configurations

## Photo Management Commands

For photo organization, use the custom `photo-cli` package:

```bash
# Copy photos with folder hierarchy preservation
photo-cli copy \
  --process-type SubFoldersPreserveFolderHierarchy \
  --naming-style DateTimeWithSecondsAddress \
  --number-style PaddingZeroCharacter \
  --folder-append DayRange \
  --folder-append-location Prefix \
  --reverse-geocode OpenStreetMapFoundation \
  --openstreetmap-properties country city town suburb \
  --no-coordinate InSubFolder \
  --no-taken-date InSubFolder \
  --verify \
  --output ~/Photos

# Flatten all subfolders with address-based grouping
photo-cli copy \
  --process-type FlattenAllSubFolders \
  --group-by AddressHierarchy \
  --naming-style DayAddress \
  --reverse-geocode OpenStreetMapFoundation \
  --openstreetmap-properties country city town suburb \
  --number-style OnlySequentialNumbers \
  --no-taken-date AppendToEndOrderByFileName \
  --no-coordinate InSubFolder \
  --input ~/Backup \
  --output ~/Photos \
  --dry-run --verify
```
