# Project Zomboid Build 42 Modding Template

A comprehensive template and guide for creating mods for Project Zomboid Build 42. This repository serves as a reference for proper mod structure and implementation, using a simple UI mod (Ammo Display) as a practical example.

The included example mod shows ammunition count for equipped firearms, but the main focus is on demonstrating proper Build 42 mod structure, Lua implementation, and cross-build compatibility techniques.

## Example Mod Features
- Displays current/maximum ammunition for equipped firearms
- Shows chambered round status (+1 indicator)
- Color-coded ammunition status (red for low, yellow for medium, white for full)
- Draggable interface
- Supports both Build 41 and Build 42

## Wiki
https://pzwiki.net/wiki/Modding

## Installation

### Manual Installation
1. Download and extract to your Project Zomboid workshop folder:
   - Windows: `C:/Users/YourUsername/Zomboid/Workshop/`
   - Linux: `~/.zomboid/Workshop/`
2. Enable the mod in the game's Mod menu

## For Modders - Using This As a Template

### Build 42 Structure
```
YourMod/
├── Contents/
│   └── mods/
│       └── YourMod/
│           ├── common/             # Shared resources for all versions
│           │   └── media/
│           │       └── lua/
│           │           └── client/
│           │               └── YourCode.lua
│           ├── 42/                # Build 42 specific files
│           │   ├── mod.info
│           │   └── poster.png
│           └── 41/                # Build 41 specific files (optional)
│               ├── mod.info
│               └── poster.png
└── workshop.txt                   # Workshop configuration
```

### Build 41 Structure (Alternative)
```
YourMod/
└── media/
    └── lua/
        └── client/
            └── YourCode.lua
```

### Creating Your Own Mod

1. Clone this repository or copy the structure
2. Modify the mod.info files:
   ```
   name=Your Mod Name
   id=YourModID
   description=Your mod description
   poster=poster.png
   ```

3. Update workshop.txt:
   ```
   version=1
   id=yourWorkshopID
   title=Your Mod Title
   description=Your mod description
   visibility=public
   ```

4. Place your code in the appropriate folders:
   - For Build 42: `common/media/lua/`
   - For Build 41: `media/lua/`

### Supporting Both Builds

To support both Build 41 and 42:

1. Keep shared code in the `common` folder
2. Create specific version folders (41/ and 42/) with their own mod.info files
3. Use version-specific code when needed in the respective folders