# SCR-Autopilot
A working autopilot (nearly) for the game Stepford Country Railway. You will still need to click "Next Leg" manually, however this can be done easily through the use of an autoclicker.
## Download
* Download `SCR auto.lua` for the auto driving script.
* Download `SCR guard.lua` for the auto guard script. It is recommended to do this in a private server as this does not follow all rules as stated in the operations guide.
## Reccomended Routes
If the train undershoots the station (virtually guaranteed on a station with buffers), it will adjust very slowly until it is forward enough on the platform to open its doors. Thus, a route with no stations requiring you to get close to buffers would be ideal.

As of V2.3, different modes of train power have been added. This script does not support power changeovers, so you should start the required power source before running the script. You should NEVER use battery mode, and NEVER raise the pantograph for a route with an unelectrified section.
### Metro
* **R002**, from Stepford Central to Port Benton.
* **R047**, from St Helens Bridge to Port Benton.
* **R132**, from Stepford Central to Barton, going clockwise.
* **R134**, from St Helens Bridge to Barton, going clockwise.
### Connect
* **R039**, from Benton to Leighton City.
* **R004**, from St Helens Bridge to Edgemead.
### Waterline
* **R018**, from Newry Harbour to Farleigh.
### Express
* **R086**, from Newry to Leighton City. Note that this route has short platforms at Eden Quay, so your train is quite likely to overshoot the platforms there.
### Airlink
None.
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
