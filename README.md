# my home manager configuration

Simply run this on any system that has `nix` and a user `thomas`:
```bash
nix run github:nix-community/home-manager -- switch --flake .#thomas
```

Notes:
Rewatch this: https://www.youtube.com/watch?v=X-Lzq7jAT8I


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
