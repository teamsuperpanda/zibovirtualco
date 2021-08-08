# zibovirtualco

A virtual copilot for the B737-800X ZIBO mod

These procedures are based on Boeings FCOM and won't action unless the aircraft is configured correctly. Below are both the triggers and actions for the copilot to operate.

## Co Pilot Actions

### After Start

##### Trigger

Engines Running with Auto Brake set to RTO

##### Actions

- Generators - ON
- Pitot Heat - ON
- Anti Ice - On if 10 degrees or below & raining
- Packs - AUTO
- Isolation Valve - AUTO
- Bleeds - Configures for ENG bleeds ON and APU bleed OFF
  -- If you want a bleeds off take off then configure after copilot actions
- APU - OFF
- Flaps - Set (Needs FMC Takeoff Flap to be entered)

### Taxi

##### Trigger

Begin taxi

##### Actions

- Lights - ON
  -- Taxi, Runway Turn Off, Wing
- Blanks Lower DU (Assumed Engine display was on lower DU for start)

### Take Off

##### Trigger

Left TOGA Button pressed - Suggest to map it to your joystick

##### Actions

- Lights - ON
  -- LANDING and STROBES - ON
  Note: Not technically accurate as strobes would be on when you enter the runway but unable to script this

### Lift Off

##### Trigger

Above 80' Radio Altimeter

##### Actions

- Gear - UP

### After Take Off

##### Trigger

Above 'UP' Speed, Flaps Up & above 1000' Radio Altimeter

##### Actions

- Gear - OFF
- Autobrake - OFF
- WING ANTI-ICE - OFF
  -- Zibo doesn't accurately model this as it should turn off at lift off automatically)

### 10,000'

##### Trigger

Climb or descend through 10,000'

##### Actions

- Lights set for cruise; or
- Lights set for landing

### After Landing

##### Trigger

Reverses stowed, below 20 kts Ground Speed

##### Actions

- SPEEDBRAKE - Stowed
- PROBE HEAT - OFF
- AUTOBRAKE - OFF
- ANTI ICE - Turns Off Engine Anti Ice is not required
- WEATHER RADAR - OFF (Both Capt and FOs ND)
- APU - Start
- FLAP - UP
- Lights - Landing OFF, Navs to Steady
- TIMER - Starts Captains timer for 3 minute cool down

### Arrive at Gate

##### Trigger

APU Running and Start Lever 2 CUTOFF

##### Actions

- APU GEN - ON BUS when you shut ENG 2 Down,
- Now shutdown ENG 1

### Shutdown

##### Trigger

Engines Shutdown

##### Actions

- Fuel Pumps - CONFIGURED
- Seat Belt Sign - OFF
- HYD ELEC PUMPS - OFF
- ISOLATION VALVE - OPEN
- APU BLEED - ON
- FLIGHT DIRECTORS - OFF
- (Below 15% N2) BEACON - OFF

## Required Plugins

FlyWithLua NG
https://forums.x-plane.org/index.php?/files/file/38445-flywithlua-ng-next-generation-edition-for-x-plane-11-win-lin-mac/

## Installation

Place the zibo.lua script file into the `FlyWithLua/Scripts` folder

## Development

Open a Github Issue for any suggestions or issues
