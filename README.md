# fl_nametag

## Dependencies

- [ESX Legacy](https://github.com/esx-framework/esx-legacy 'ESX Legacy')
- [oxmysql](https://github.com/overextended/oxmysql 'oxmysql')

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
