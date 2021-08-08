-- Variables
message_count = 101
message_content = ""
tailcoded = "ZB738"

beforetaxi = false
taxi = false
takeoff = false
liftoff = false
aftertakeoff = false
afterlanding = false
arriveatgate = false
shutdown = false
beaconoff = false


-- Datarefs 
-- AIRCRAFT
dataref("TAIL", "sim/aircraft/view/acf_tailnum", "readable")
dataref("FMC_FLAP", "laminar/B738/FMS/takeoff_flaps", "readable") -- T/O FLAP FROM FMC
dataref("PARK_BRAKE", "sim/flightmodel/controls/parkbrake", "readable")
dataref("ALT", "sim/cockpit2/gauges/indicators/altitude_ft_pilot", "readable")
dataref("RADALT", "sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "readable")
dataref("GS", "laminar/b738/fmodpack/real_groundspeed", "readable")
dataref("ONGROUND", "laminar/B738/air_ground_sensor", "readable") -- 1 on ground
dataref("UP_SPEED", "laminar/B738/pfd/flaps_up", "readable")
dataref("FO_FD", "laminar/B738/autopilot/flight_director_fo_pos", "readable")
dataref("TOGA", "laminar/B738/autopilot/left_toga_pos", "readable")
dataref("IAS", "sim/flightmodel/position/indicated_airspeed", "readable")
-- LIGHTS
dataref("BEACON", "sim/cockpit/electrical/beacon_lights_on", "writeable")
dataref("TURNOFF_LEFT", "laminar/B738/toggle_switch/rwy_light_left", "writable")
dataref("TURNOFF_RIGHT", "laminar/B738/toggle_switch/rwy_light_right", "writable")
-- AUTOBRAKE
dataref("AUTOBRAKE_DISARM_LIGHT", "laminar/B738/autobrake/autobrake_disarm", "readable")
dataref("AUTOBRAKE_ARM", "laminar/B738/autobrake/autobrake_RTO_arm", "readable")
-- SPEEDBRAKE
dataref("SPEEDBRAKE_LEVER", "laminar/B738/flt_ctrls/speedbrake_lever", "writeable")
-- ENGINES
dataref("REVERSE", "laminar/B738/flt_ctrls/reverse_lever12", "readable")
dataref("APU", "sim/cockpit/engine/APU_running", "readable")
dataref("ENG1_N1", "laminar/B738/engine/indicators/N1_percent_1", "readable")
dataref("ENG2_N1", "laminar/B738/engine/indicators/N1_percent_2", "readable")
dataref("ENG1_N2", "laminar/B738/engine/indicators/N2_percent_1", "readable")
dataref("ENG2_N2", "laminar/B738/engine/indicators/N2_percent_2", "readable")
dataref("ENG_STARTER1", "laminar/B738/engine/starter1_pos", "readable")
dataref("ENG_STARTER2", "laminar/B738/engine/starter2_pos", "readable")
dataref("AUTOTHROTTLE", "laminar/B738/autopilot/autothrottle_arm_pos", "readable")
dataref("START_LEVER1", "laminar/B738/engine/mixture_ratio1", "readable")
dataref("START_LEVER2", "laminar/B738/engine/mixture_ratio2", "readable")
-- EFIS
dataref("WX_RADAR", "sim/cockpit/switches/EFIS_shows_weather", "readable")
-- FLAPS
dataref("SLATS", "laminar/B738/annunciator/slats_transit", "readable") -- 1 means moving
dataref("FLAP_LEVER", "laminar/B738/flt_ctrls/flap_lever", "writeable") -- 0 means lever @ UP
dataref("FLAPS", "sim/cockpit2/controls/flap_handle_deploy_ratio", "readable")
-- GEAR
dataref("GEAR", "laminar/B738/controls/gear_handle_down", "writeable") -- 0 UP 0.5 OFF 1 DWN
-- ANTI-ICE / PROBES
dataref("EAI1", "laminar/B738/ice/eng1_heat_pos", "writeable")
dataref("EAI2", "laminar/B738/ice/eng2_heat_pos", "writeable")
dataref("WAI", "laminar/B738/ice/wing_heat_pos", "writeable")
dataref("PROBE1", "laminar/B738/toggle_switch/capt_probes_pos", "writeable")
dataref("PROBE2", "laminar/B738/toggle_switch/fo_probes_pos", "writeable")
-- ELECTRICAL
dataref("GEN1", "laminar/B738/electrical/gen1_pos", "writeable")
dataref("GEN2", "laminar/B738/electrical/gen2_pos", "writeable")
dataref("APU_GEN", "laminar/B738/annunciator/apu_gen_off_bus", "readable") -- 1 means on but not on bus
dataref("GPU", "laminar/B738/gpu_available", "readable")
-- AIRCON
dataref("LPACK", "laminar/B738/air/l_pack_pos", "writeable")
dataref("RPACK", "laminar/B738/air/r_pack_pos", "writeable")
dataref("ISOLATIONVALVE", "laminar/B738/air/isolation_valve_pos", "writeable")
dataref("APU_BLEED", "laminar/B738/toggle_switch/bleed_air_apu_pos", "writeable")
-- GENERAL / SIM
dataref("X_TEMP", "laminar/B738/systems/temperature/tat_degc", "readable")
dataref("X_RAIN", "sim/weather/rain_percent", "readable")
dataref("TUG", "bp/connected", "readable")
dataref("SUNDEG", "sim/graphics/scenery/sun_pitch_degrees", "readable")


-- Scripts
-- MESSAGE
function MESSAGE()
	if (message_count <= 100) then
	local pos = 0
	pos = big_bubble(20, pos, message_content)
	message_count = message_count + 1
	end
end

-- AFTER START
function AFTER_START()
  if (beforetaxi == false and TAIL == tailcoded and ENG1_N1 > 18 and ENG2_N1 > 18 and AUTOBRAKE_ARM == 1 and ENG_STARTER1 == 1 and ENG_STARTER2 == 1) then 
    beforetaxi = true

    -- Electrical
    command_once("laminar/B738/toggle_switch/gen1_dn")
    command_once("laminar/B738/toggle_switch/gen2_dn")
    -- Probes
    PROBE1 = 1
    PROBE2 = 1
    -- Anti Ice Logic
    if (X_TEMP < 11 and X_RAIN > 0.08) then
      WAI = 1 -- Wing Anti-Ice
      EAI1 = 1 -- Engine Anti Ice
      EAI2 = 1
    end
    -- Aircon
    LPACK = 1
    RPACK = 1
    ISOLATIONVALVE = 1
    APU_BLEED = 0
    command_once("laminar/B738/spring_toggle_switch/APU_start_pos_up") -- APU Switch to OFF
    -- Flap Logic
    command_once("sim/flight_controls/flaps_down") -- Creates Flap Handle Noise
    if (FMC_FLAP == 1) then
      FLAP_LEVER = 0.125
    elseif (FMC_FLAP == 5) then
      FLAP_LEVER = 0.375
    elseif (FMC_FLAP == 10) then
      FLAP_LEVER = 0.5
    elseif (FMC_FLAP == 15) then
      FLAP_LEVER = 0.625
    else
      FLAP_LEVER = 0.75
    end

  end
end


-- TAXI OUT
function TAXI()
  if (taxi == false and beforetaxi == true and TAIL == tailcoded and AUTOBRAKE_ARM == 1 and PARK_BRAKE == 0 and ENG1_N1 > 18 and ENG2_N1 > 18 and TUG == 0) then 
    taxi = true
    -- Blank Lower DU
    command_once("laminar/B738/LDU_control/push_button/MFD_ENG")
    command_once("laminar/B738/LDU_control/push_button/MFD_ENG")

    -- Lights
    command_once("laminar/B738/toggle_switch/taxi_light_brightness_on")
    command_once("laminar/B738/switch/wing_light_on")
    TURNOFF_LEFT = 1
    TURNOFF_RIGHT = 1
  end
end


-- TAKE OFF
function TAKEOFF()
  if (takeoff == false and TAIL == tailcoded and TOGA == 1) then 
    takeoff = true
    message_content = "Lights On"
    message_count = 1

    command_once("laminar/B738/spring_switch/landing_lights_all")
    command_once("laminar/B738/toggle_switch/position_light_strobe") -- Not accurate as strobes would be on entering runway
  end
end


-- LIFT OFF
function LIFTOFF()
  if (liftoff == false and TAIL == tailcoded and RADALT > 80 and ONGROUND == 0) then
    liftoff = true

    GEAR = 0
  end
end

-- AFTER TAKE OFF
function AFTERTAKEOFF()
  if (aftertakeoff == false and TAIL == tailcoded and RADALT > 1000 and ONGROUND == 0 and SLATS == 0 and FLAP_LEVER == 0 and FLAPS == 0 and GEAR == 0 and IAS > UP_SPEED) then 
    aftertakeoff = true

    command_once("laminar/B738/knob/autobrake_off")
    GEAR = 0.5
  end
end


-- LIGHTS ABOVE AND BELOW 10,000
function ABOVETENTHOUSAND()
  if (TAIL == tailcoded and ONGROUND == 0 and ALT >10000) then 
    -- LOGO
    command_once("laminar/B738/switch/logo_light_off")
    -- LANDING
    command_once("sim/lights/landing_lights_off")
    -- TAXI
    command_once("laminar/B738/toggle_switch/taxi_light_brightness_off")
    command_once("laminar/B738/switch/wing_light_off")
    TURNOFF_LEFT = 0
    TURNOFF_RIGHT = 0
    -- NAV
    command_once("laminar/B738/toggle_switch/position_light_strobe")
    -- BEACON
    BEACON = 1
    end
end

function BELOWTENTHOUSAND()
  if (TAIL == tailcoded and ONGROUND == 0 and ALT <10000) then 
    -- LOGO
    if (SUNDEG < 0) then
    command_once("laminar/B738/switch/logo_light_on") else
    command_once("laminar/B738/switch/logo_light_off")
    end
    -- LANDING
    command_once("laminar/B738/spring_switch/landing_lights_all")
    -- TAXI
    command_once("laminar/B738/toggle_switch/taxi_light_brightness_on")
    command_once("laminar/B738/switch/wing_light_on")
    TURNOFF_LEFT = 1
    TURNOFF_RIGHT = 1
    -- NAV
    command_once("laminar/B738/toggle_switch/position_light_strobe")
    -- BEACON
    BEACON = 1
  end
end

-- AFTER LANDING
function AFTER_LANDING()
  if (afterlanding == false and TAIL == tailcoded and AUTOBRAKE_DISARM_LIGHT == 1 and GS < 20 and REVERSE == 0) then 
    afterlanding = true

    SPEEDBRAKE_LEVER = 0
    PROBE1 = 0
    PROBE2 = 0
    command_once("laminar/B738/knob/autobrake_off")
    -- Anti Ice Logic
    if (X_TEMP < 11 and X_RAIN > 0.08) then
      EAI1 = 0
      EAI2 = 0
    end
    -- Weather Radar (Turns off Terrain Too)
    command_once("laminar/B738/EFIS_control/fo/push_button/wxr_press")
    command_once("laminar/B738/EFIS_control/capt/push_button/wxr_press")
    if (WX_RADAR == 1) then
      command_once("laminar/B738/EFIS_control/capt/push_button/wxr_press")
      if (WX_RADAR == 1) then
        command_once("laminar/B738/EFIS_control/capt/push_button/wxr_press")
      end
    end
    -- APU START
    if (APU == 0) then
    command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
    command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
    end
    -- Flap
    command_once("sim/flight_controls/flaps_up")
    FLAP_LEVER = 0
    -- Lights
    command_once("laminar/B738/toggle_switch/position_light_steady") -- NAV Lights Steady
    command_once("sim/lights/landing_lights_off") 
    -- Start Timer
    command_once("laminar/B738/push_button/chrono_cycle_capt") -- 3 Minute Cool Down
  end
end


-- ARRIVE AT GATE
function AT_GATE()
  if (arriveatgate == false and TAIL == tailcoded and START_LEVER1 == 1 and START_LEVER2 == 0 and GS < 0.5 and PARK_BRAKE == 1 and APU_GEN == 1) then 
    arriveatgate = true

    command_once("laminar/B738/toggle_switch/apu_gen2_dn")
    command_once("laminar/B738/toggle_switch/apu_gen1_dn")
  end
end

function SHUT_DWN()
  if (arriveatgate == true and shutdown == false and TAIL == tailcoded and START_LEVER1 ==0 and START_LEVER2 == 0 and APU_GEN == 0) then
    shutdown = true

    command_once("laminar/B738/toggle_switch/fuel_pump_lft1")
    command_once("laminar/B738/toggle_switch/fuel_pump_rgt1")
    command_once("laminar/B738/toggle_switch/fuel_pump_rgt2")

    command_once("laminar/B738/toggle_switch/seatbelt_sign_up")
    command_once("laminar/B738/toggle_switch/seatbelt_sign_up")

    command_once("laminar/B738/toggle_switch/electric_hydro_pumps1")
    command_once("laminar/B738/toggle_switch/electric_hydro_pumps2")
    command_once("laminar/B738/toggle_switch/seatbelt_sign_up")

    PROBE1 = 0
    PROBE2 = 0
    APU_BLEED = 1
    ISOLATIONVALVE = 2
    command_once("laminar/B738/autopilot/flight_director_toggle")
    -- FO Flight Director Logic
    if (FO_FD == 1) then
      command_once("laminar/B738/autopilot/flight_director_fo_toggle")
    end
  end
end

function BEACON_OFF()
  if (arriveatgate == true and TAIL == tailcoded and shutdown == true and beaconoff == false and ENG1_N2 < 15 and ENG2_N2 < 15) then
    beaconoff = true

    BEACON = 0
  end
end

-- Run Scripts
do_every_draw("MESSAGE()")

do_often("AFTER_START()")
do_often("TAXI()")

do_every_draw("TAKEOFF()")
do_every_frame("LIFTOFF()")
do_every_frame("AFTERTAKEOFF()")

do_often("ABOVETENTHOUSAND()")
do_often("BELOWTENTHOUSAND()")

do_often("AFTER_LANDING()")
do_often("AT_GATE()")
do_often("SHUT_DWN()")
do_often("BEACON_OFF()")