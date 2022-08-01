<p align="center">
<img src="https://github.com/fivemland/fl_nametag/blob/main/assets/logo.png " width="100" height="100">
</p>

# fl_nametag

[![https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png')](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png')
[![https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png')](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png')

## Commands

- /togmyname - own name display on / off
- /changename - Change player In-Game nick

## Dependencies

- [ESX Legacy](https://github.com/esx-framework/esx-legacy 'ESX Legacy')
- [oxmysql](https://github.com/overextended/oxmysql 'oxmysql')

### Optional

- [fl_adminpanel](https://github.com/fivemland/fl_adminpanel 'fl_adminpanel') - Support admin functions (logo, name)

## Exports

### Client

#### setMyNameVisible

- state: boolean
- Sets my name visible state

```lua
setMyNameVisible(state)
```

#### getMyNameVisible

- return boolean

```lua
local myName = getMyNameVisible()
```

### Server

##### getPlayerFirstJoin

- player: serverId
- return: unix timestamp

```lua
local firstJoin = getPlayerFirstJoin(player)
```
