# Avorion Commands Package
Pull Requests and/or patches are welcome.

Personally, I don't plan to dedicate any time to this.  I will review
and merge any changes from others.  Traffic and use seems very low.
Forum thread is inactive since 2019.

If any active Avorion player is willing to take over the repository,
feel free to open an Issue or send me an e-mail.


## Commands
### /crew
Adds or removes crew to currently boarded ship. Usage:
`/crew help` or `/crew` for help
`/crew add <profession> [rank] [level] [amount]`
`/crew fill`
`/crew clear`

### /inventory
Alias: `/inv`
Modifies inventory of a player. Usage:
`/inventory turret <type> [rarity] [material] [tech] [amount]`
`/inventory upgrade <script> [rarity] [amount]`

### /price
Prints price of currently boarded ship. Usage: `/price`

### /sethome
Allows player to change home sector to current if friendly or own station
is present. Usage: `/sethome`

### /whereis
Gets the position of a player. Usage: `/whereis <name>`

### /list
Lists possible variables for `/inventory`, `/crew` or `/fighter`. Usage:
`/list [type]`. Use `/list` to print types.  `/list <type>` `/list help`
or `/list` for help.

### /disttocore
Display the distance in sectors between the player and the center of
the galaxy. Usage `/disttocore`

### /agoods

Adds goods to currently boarded ship. Usage:

`/agoods <good name> <quantity>`

Must capitalize all names
Must replace spaces with _(underscore)
Can not add more then your hold can handle

#### Examples:

`/agood Steel 100`
`/agood Steel_Tube 10`

### /fighter
Adds a fighter to the payers hanger. Usage:
`/fighter add <weapons> [rarity] [material] [tech]`
