# zibovirtualco

A virtual copilot for the B737-800X ZIBO mod.

The actions carried out by the virtual copilot are based on Boeing's FCOM, modified to match an anonymous airline's standard operating procedures.  


## Installation

Go to the X-Plane installation folder and copy the ``zibo.lua`` script file into the `/Resources/plugins/FlyWithLua/Scripts` folder. 

### Required Plugins

[FlyWithLua NG](https://forums.x-plane.org/index.php?/files/file/38445-flywithlua-ng-next-generation-edition-for-x-plane-11-win-lin-mac/)


## How it works

Configure the aircraft for each phase of flight as documented below to ensure the correct copilot actions are triggered. Each procedure must be completed for the subsequent procedure to trigger. 

### After Start

**Configuration**: Engines running with Autobrake set to RTO

|System|Action|Notes|
|:-------|:-----|:------|
|Generators |ON||
|Pitot Heat | ON||
|Anti Ice |ON | 10 degrees or below & raining|
|Packs|AUTO||
|Isolation Valve| AUTO||
|Bleeds|ENG bleeds ON and APU bleed OFF|For a bleeds off take off, configure after copilot actions|
|APU|OFF||
|Flaps |Set to FMC Takeoff Flap||

### Taxi

**Configuration**:  Park brake released with no tug attached. 

|System|Action|Notes|
|:-------|:-----|:------|
|Lights|ON|Taxi, Runway Turn Off, and Wing|
|Lower DU|Blanked| Assumes Engine display was on lower DU for start|

### Before takeoff

**Configuration**: Left TOGA Button pressed. Map the left TOGA button to your joystick to ensure correct actions.


|System|Action|Notes|
|:-------|:-----|:------|
|Lights|ON|LANDING and STROBES|

Note: This is not technically accurate as the strobes should be on when you enter the runway, however it's not possible to script this.

### Liftoff

**Configuration**: Above 80' Radio Altimeter
|System|Action|Notes|
|:-------|:-----|:------|
|Gear|UP||


### After takeoff

**Configuration**: Above 'UP' speed, flaps Up & above 1000' Radio Altimeter.

|System|Action|Notes|
|:-------|:-----|:------|
|Gear|OFF||
|Autobrake|OFF||
|WING ANTI-ICE|OFF|Zibo doesn't accurately model this as it should turn off automatically at lift off| 

### Through 10,000'

**Configuration**: Climbing or descending through 10,000 feet.

|System|Action|Notes|
|:-------|:-----|:------|
|Lights| Set for cruise|All lights off, except beacon and strobes |
|Lights| Set for landing|All lights on, except logo light by day|

### After Landing

**Configuration**: Reversers stowed, below 20 kts ground speed

|System|Action|Notes|
|:-------|:-----|:------|
|SPEEDBRAKE|Stowed||
|PROBE HEAT|OFF||
|AUTOBRAKE|OFF||
|ANTI ICE|OFF| If Engine Anti Ice is not required
|WEATHER RADAR| OFF| Both Capt and FO ND|
|APU|Start||
|FLAP|UP||
|Lights| Landing OFF, Navs to Steady||
|TIMER|Start| Starts Captain's timer for 3 minute cool down|

### Arrive at gate

**Configuration**:APU Running and Engine start lever 2 CUTOFF

|System|Action|Notes|
|:-------|:-----|:------|
|APU GEN| ON BUS||

Note: Once the APU GEN is on the bus, shut down engine 1

### Shutdown

**Configuration**: Both engines shut down

|System|Action|Notes|
|:-------|:-----|:------|
|Fuel Pumps|CONFIGURED|Left Main FWD fuel pump remains on for the APU|
|Seat Belt Sign|OFF||
|HYD ELEC PUMPS|OFF||
|ISOLATION VALVE|OPEN||
|APU BLEED|ON||
|FLIGHT DIRECTORS|OFF|
|BEACON|OFF| Once N2 is below 15%|


## Development

Open a Github Issue for any suggestions or issues.
