# Meili (Mɛile)

> In Norse mythology, Meili (Old Norse: [ˈmɛile], 'the lovely one'[1]) is a god, son of the god Odin and Jörð, and brother of the god Thor. Meili is attested in the Poetic Edda, compiled in the 13th century from earlier traditional sources, and the Prose Edda, written in the 13th century by Snorri Sturluson. Other than Meili's relation to Odin and Thor, no additional information is provided about the deity in either source.

## Installation

```bash
nix run github:lnl7/nix-darwin -- switch --flake .#meili
nix run github:nix-community/home-manager -- switch --flake .#thomas@meili
```

## Services and Applications

### AeroSpace

i3 style tiling manager

#### Hacks

I had to hack in a way to move between splits and windows seamlessly. Basically what I'm doing is when I press ctrl+{h,j,k,l} it executes a script that checks if we're in a TMUX window and if that's the case it checks if we have a split to move to or not, if not it executes `aerospace focus`.


### Zen Browser

Not able to package Zen Browser with Nix yet.

### LogSeq

This is going to become my new knowledge base.

### Raycast
### Ghostty

Ghostty is still broken on darwin systems. But the master branch of home-manager allows to set the package to null which means we can install the package via homebrew and use home-manager to configure.

### Open Audible
### Signal (Molly)
### ProtonVPN
### VLC
### Yubi Authenticator

