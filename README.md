<p align="center">
<img src="https://github.com/fivemland/fl_nametag/blob/main/assets/logo.png " width="100" height="100">
</p>

<h1 align="center">
FiveM Land Nametag
</h1>

[![https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png')](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot.png')
[![https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png')](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot2.png')
[![https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot3.png](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot3.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot3.png')](https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot3.png 'https://github.com/fivemland/fl_nametag/blob/main/screenshots/Screenshot3.png')

## Commands

- /togmyname - own name display on / off
- /changename - Change player In-Game nick
- /names - toggle names visibility
- /jelveny - toggle job badge

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
exports.fl_nametag:setMyNameVisible(state)
```

#### getMyNameVisible

- return boolean

```lua
local myName = exports.fl_nametag:getMyNameVisible()
```

#### setNamesVisible

- set nametag visible

```lua
exports.fl_nametag:setNamesVisible(state)
```

#### isNamesVisible

- return: boolean

```lua
local namesVisible = exports.fl_nametag:isNamesVisible()
```

#### isPlayerInJobduty

- returns wether the player is in JobDuty

```lua
local jobDuty = exports.fl_nametag:isPlayerInJobduty()
```

#### getPlayerJobLabel

- returns the jobs label

```lua
local jobLabel = exports.fl_nametag:getPlayerJobLabel()
```

### Server

##### getPlayerFirstJoin

- player: serverId
- return: unix timestamp

```lua
local firstJoin = exports.fl_nametag:getPlayerFirstJoin(player)
```

#### isPlayerInJobduty

- returns wether the player is in JobDuty

```lua
local jobDuty = exports.fl_nametag:isPlayerInJobduty()
```