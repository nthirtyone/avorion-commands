# Avorion Commands Package
## New commands
Currently package is open for any pull requests containing completely new commands that provides any useful functionality to the player or server administrator.
## Modifying existing commands
Before modifying any existing command we highly recommend talking with anyone about it. Project currenlty lacks and kind of road map, development tips or overall design.
## /crew
Adds or removes crew to currently boarded ship. Usage:
`/crew help` or `/crew` for help
`/crew add <profession> [rank] [level] [amount]`
`/crew fill`
`/crew clear`
## /inventory
Alias: `/inv`
Modifies inventory of a player. Usage:
`/inventory turret <type> [rarity] [material] [tech] [amount]`
`/inventory upgrade <script> [rarity] [amount]`
## /price
Prints price of currently boarded ship. Usage: `/price`
## /sethome
Allows player to change home sector to current if friendly or own station is present. Usage: `/sethome`
## /whereis
Gets the position of a player. Usage: `/whereis <name>`
## /list
Lists possible variables for `/inventory` or `/crew`. Usage: 
`/list <type>`
`/list help` or `/list` for help.

## /agoods

Adds goods to currently boarded ship. Usage:

`/agoods <good name> <quantity>`

Must capitalize all names
Must replace spaces with _(underscore)
Can not add more then your hold can handle

### Examples:

`/agood Steel 100`
`/agood Steel_Tube 10`
