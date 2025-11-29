# SCR-Autopilot
A working autopilot (nearly) for the game Stepford Country Railway. You will still need to click "Next Leg" manually, however this can be done easily through the use of an autoclicker.
## Tested
Default values tested on class 357 4-car.
If you are driving a different train, you may need to change the values of the three variables at the top of the code. For example, if you wish to drive an Express class 80x, you should probably use these values (which have not been tested):
```lua
-- The maximum speed of your train.
local MAXSPEED = 125

-- The speed the train should slow down to when getting close to the station.
local SAFESTOPSPEED = 50

-- The distance in miles from the station your train should reach before stopping.
local SAFESTOPDISTANCE = 0.55
```
## How to use
Simply load the script using an executor of your choice, ***AFTER YOU HAVE SPAWNED IN YOUR TRAIN***. After you have started the script, ***DO NOT INTERFERE*** with the driving.
