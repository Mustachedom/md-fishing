#  md-fishing - Fishing Throughout Los Santos

<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img src="https://i.imgur.com/t65G9Z0.png" width="200" alt="Mustache Scripts Logo">
  </a>
  <br>
  <a href="https://discord.gg/sAMzrB4DDx"><strong>Join Mustache Scripts Discord</strong></a>
</div>

---
## Video
- [Rottenberger Video](https://www.youtube.com/watch?v=07dFZMks5e8)

## 📦 Dependencies

| Dependency | Link |
|----------|------|
| `ps_lib` | [GitHub - Project-Sloth/ps_lib](https://github.com/Project-Sloth/ps_lib) |
| `Read`   | [Read Docs](https://letters.hookedonphonics.com/us/read-guaranteed-G14.html) |

> ⚠️ Ensure all dependencies are installed, up to date, and ensure **BEFORE** this script, before proceeding.


## 🛠️ Installation
### Step 1: Inventory Integration

#### For QBCore (`qb-inventory`)
1. Copy items from `md-fishing/itemlist/qb.md` into `qb-core/shared/items.lua`.
2. Add item images from `md-drugs/items_install/images` to `qb-inventory/html/images` or your other inventory.

#### For OX_Inventory
1. Copy items from `md-fishing/itemlist/ox.md` into `ox_inventory/data/items.lua`.
2. Add item images to `ox_inventory/web/images`.

---
### STEP 2
- Run SQL
    - if you dont know how, click this image below
    - [![YouTube Video](https://img.youtube.com/vi/8QpFOluK_xo/hqdefault.jpg)](https://www.youtube.com/watch?v=8QpFOluK_xo)

---
### Step 3 Configure The Script To your liking
- Everything Is in the server_config.lua OR Config.lua
  - adjust what you will like.

# MAJOR IMPORTANT STEP 
## IF YOU USE THE OLDER VERSION OF MD-FISHING PLEASE READ BELOW IF NOT YOU CAN IGNORE


### AFTER INSTALLING AND BEFORE FLYING IN GO INTO TXADMIN CONSOLE AND RUN THIS COMMAND `FishingReFormater` THEN WAIT A FEW SECONDS. DELETE IT FROM line 514-end of server.lua
### THEN RESTART YOUR SERVER. THIS WILL AUTO UPDATE ALL PLAYER DATA TO NEW FORMAT

