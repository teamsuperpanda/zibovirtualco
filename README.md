# zibovirtualco

A virtual copilot for the B737-800X ZIBO mod.

zibovirtualco is a silent virtual co-pilot that helps you in the background. Real airline operations have a pilot monitoring and a pilot flying so why not get the help you deserve.
The actions carried out by the virtual copilot are based on Boeing's FCOM, modified to match an anonymous airline's standard operating procedures.

## Installation

Go to the X-Plane installation folder and copy the `zibovirtualco.lua` script file into the `/Resources/plugins/FlyWithLua/Scripts` folder.

## Update

To update to a newer version simply download the latest release and replace the `zibovirtualco.lua` script file into the `/Resources/plugins/FlyWithLua/Scripts` folder.

### Required Plugins

[FlyWithLua NG](https://forums.x-plane.org/index.php?/files/file/38445-flywithlua-ng-next-generation-edition-for-x-plane-11-win-lin-mac/)

## How it works

Configure the aircraft for each phase of flight as documented below to ensure the correct copilot actions are triggered. Each procedure must be completed for the subsequent procedure to trigger. A small bubble message on the bottom left lets you know the virtual copilot has actioned a checklist.

### Pushback

**Configuration**: Tug connected with chocks removed and park brake released

| System          | Action | Notes |
| :-------------- | :----- | :---- |
| BEACON          | ON     |       |
| PACKS           | OFF    |       |
| ISOLATION VALVE | OPEN   |       |
| APU             | OFF    |       |

### Engine 2 Start

**Configuration**: Pushback in progress

| System       | Action | Notes |
| :----------- | :----- | :---- |
| ENG2 STARTER | GND    |       |

### Engine 1 Start

**Configuration**: Pushback in progress and Engine 2 started

| System       | Action | Notes |
| :----------- | :----- | :---- |
| ENG1 STARTER | GND    |       |

### After Start

**Configuration**: Engines running with Autobrake set to RTO

| System                   | Action                          | Notes                                                        |
| :----------------------- | :------------------------------ | :----------------------------------------------------------- |
| GENERATOR 1 and 2        | ON                              |                                                              |
| PROBE HEAT               | ON                              |                                                              |
| WING and ENGINE ANTI-ICE | ON                              | 10 degrees or below & raining                                |
| PACKS                    | AUTO                            |                                                              |
| ISOLATION VALVE          | AUTO                            |                                                              |
| Bleeds                   | ENG bleeds ON and APU bleed OFF | For a bleeds off take off, reconfigure after copilot actions |
| APU                      | OFF                             |                                                              |
| Flaps                    | Set to FMC Takeoff Flap         |                                                              |

### Taxi

**Configuration**: Park brake released with no tug attached.

| System   | Action  | Notes                          |
| :------- | :------ | :----------------------------- |
| Lights   | ON      | TAXI, RUNWAY TURNOFF, and WING |
| Lower DU | Blanked |                                |

### Before takeoff

**Configuration**: Left TOGA Button pressed. Map the left TOGA button to your joystick to ensure correct actions.

| System | Action | Notes                                      |
| :----- | :----- | :----------------------------------------- |
| Lights | ON     | LANDING and POSITION light STROBE & STEADY |

Note: This is not technically accurate as the strobes should be on when you enter the runway, however it's not possible to script this.

### Liftoff

**Configuration**: Above 80' Radio Altimeter
|System|Action|Notes|
|:-------|:-----|:------|
|Landing gear lever|UP||
|WING ANTI-ICE|OFF|Zibo doesn't accurately model this as it should turn off automatically at lift off|

### After takeoff

**Configuration**: Above 'UP' speed, flaps Up & above 1000' Radio Altimeter.

| System             | Action | Notes |
| :----------------- | :----- | :---- |
| Landing gear lever | OFF    |       |
| AUTO BRAKE         | OFF    |       |

### Through 10,000'

**Configuration**: Climbing or descending through 10,000 feet.

| System | Action          | Notes                                                                    |
| :----- | :-------------- | :----------------------------------------------------------------------- |
| Lights | Set for cruise  | All lights off, except ANTI COLLISION and POSITION light STROBE & STEADY |
| Lights | Set for landing | All lights on, except LOGO light by day                                  |

### After Landing

**Configuration**: Reversers stowed, below 20 kts ground speed

| System        | Action                                    | Notes                                                            |
| :------------ | :---------------------------------------- | :--------------------------------------------------------------- |
| SPEED BRAKE   | DOWN                                      |                                                                  |
| PROBE HEAT    | AUTO                                      | In some aircraft configurations, this may be OFF instead of AUTO |
| AUTO BRAKE    | OFF                                       |                                                                  |
| ANTI ICE      | OFF                                       | If Engine Anti Ice is not required                               |
| Weather radar | OFF                                       | Both Capt and FO ND                                              |
| APU           | Start                                     |                                                                  |
| FLAPS         | UP                                        |                                                                  |
| Lights        | LANDING lights OFF, POSITION light STEADY |                                                                  |
| Timer         | Start                                     | Starts the Captain's timer for 3 minute cool down                |

### Arrive at gate

**Configuration**: APU Running and Engine start lever 2 CUTOFF

| System  | Action | Notes |
| :------ | :----- | :---- |
| APU GEN | ON bus |       |

Note: Once the APU GEN is on the bus, shut down engine 1

### Shutdown

**Configuration**: Both engines shut down

| System                   | Action     | Notes                                     |
| :----------------------- | :--------- | :---------------------------------------- |
| FUEL PUMPS               | Configured | Left FWD fuel pump remains on for the APU |
| FASTEN BELTS             | OFF        |                                           |
| ELECTRIC HYDRAULIC PUMPS | OFF        |                                           |
| ISOLATION VALVE          | OPEN       |                                           |
| APU BLEED                | ON         |                                           |
| FLIGHT DIRECTORS         | OFF        |
| ANTI COLLISION light     | OFF        | Once N2 is below 15%                      |

## Development

Open a Github Issue for any suggestions or issues.
