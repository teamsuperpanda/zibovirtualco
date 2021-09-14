-- ---------------------------
-- *** ZIBO VIRTUAL CO ***
-- ---------------------------

-- Author: Team Super Panda
-- AUG, 2021
-- https://github.com/teamsuperpanda/zibovirtualco
-- ---------------------------

-- Version 1.4
-- Sounds added, code formatted and rewritten in areas, options added
-- ---------------------------


-- OPTIONS
OPTIONS_VIEWTEXTBUBBLES = true
OPTIONS_PLAYSOUNDS = true

OPTIONS_STABLEAPPROACH_SPEEDPOSITIVE = 10
OPTIONS_STABLEAPPROACH_SPEEDMINUS = -5
OPTIONS_STABLEAPPROACH_RATEOFDESCENT = 1000
-- ---------------------------
-- Sound File Variables
sound_checklistcomplete = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/checklistcomplete.wav")
sound_engine1 = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/engine1.wav")
sound_engine2 = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/engine2.wav")
sound_endofflight = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/endflight.wav")
sound_landing = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/landing.wav")
sound_lightson = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/lights_on.wav")
sound_lightsoff = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/lights_off.wav")
sound_liftoff = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/liftoff.wav")
sound_notstable = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/notstable.wav")
sound_stable = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/stable.wav")
sound_sixtyknots = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/60knots.wav")
sound_taxi = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/taxi.wav")
sound_taxispeedwarning = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/plugins/FlyWithLua/Scripts/zibovirtualco/sounds/taxispeed.wav")

-- SETUP
message_count = 101
message_content = "zibovirtualco v1.4 - Ready"
tailcoded = "ZB738"
pushback = false
start1 = false
start2 = false
beforetaxi = false
taxispeedwarning = false
taxi = false
takeoff = false
liftoff = false
aftertakeoff = false
lightsaboveten = false
lightsbelowten = false
stableapproach = false
landing_touchdown = false
landing_sixtyknots = false
afterlanding = false
arriveatgate = false
shutdown = false
beaconoff = false


-- DATAREF 
--  AIRCRAFT
dataref("ALT", "sim/cockpit2/gauges/indicators/altitude_ft_pilot", "readable")
dataref("CHOCKS", "laminar/B738/fms/chock_status", "readable")
dataref("FMC_FLAP", "laminar/B738/FMS/takeoff_flaps", "readable") -- T/O FLAP FROM FMC
dataref("FO_FD", "laminar/B738/autopilot/flight_director_fo_pos", "readable")
dataref("GS", "laminar/b738/fmodpack/real_groundspeed", "readable")
dataref("IAS", "sim/flightmodel/position/indicated_airspeed", "readable")
dataref("ONGROUND", "laminar/B738/air_ground_sensor", "readable") -- 1 on ground
dataref("PARK_BRAKE", "sim/flightmodel/controls/parkbrake", "readable")
dataref("RADALT", "sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "readable")
dataref("TAIL", "sim/aircraft/view/acf_tailnum", "readable")
dataref("TOGA", "laminar/B738/autopilot/left_toga_pos", "readable")
dataref("UP_SPEED", "laminar/B738/pfd/flaps_up", "readable")
dataref("VREF", "laminar/B738/FMS/vref", "readable")
dataref("VSI", "sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "readable")
--  LIGHTS
dataref("BEACON", "sim/cockpit/electrical/beacon_lights_on", "writeable")
dataref("TURNOFF_LEFT", "laminar/B738/toggle_switch/rwy_light_left", "writable")
dataref("TURNOFF_RIGHT", "laminar/B738/toggle_switch/rwy_light_right", "writable")
--  AUTOBRAKE
dataref("AUTOBRAKE_ARM", "laminar/B738/autobrake/autobrake_RTO_arm", "readable")
dataref("AUTOBRAKE_DISARM_LIGHT", "laminar/B738/autobrake/autobrake_disarm", "readable")
--  SPEEDBRAKE
dataref("SPEEDBRAKE_LEVER", "laminar/B738/flt_ctrls/speedbrake_lever", "writeable")
--  ENGINES
dataref("APU", "sim/cockpit/engine/APU_running", "readable")
dataref("AUTOTHROTTLE", "laminar/B738/autopilot/autothrottle_arm_pos", "readable")
dataref("ENG1_N1", "laminar/B738/engine/indicators/N1_percent_1", "readable")
dataref("ENG2_N1", "laminar/B738/engine/indicators/N1_percent_2", "readable")
dataref("ENG1_N2", "laminar/B738/engine/indicators/N2_percent_1", "readable")
dataref("ENG2_N2", "laminar/B738/engine/indicators/N2_percent_2", "readable")
dataref("ENG_STARTER1", "laminar/B738/engine/starter1_pos", "readable")
dataref("ENG_STARTER2", "laminar/B738/engine/starter2_pos", "readable")
dataref("REVERSE", "laminar/B738/flt_ctrls/reverse_lever12", "readable")
dataref("START_LEVER1", "laminar/B738/engine/mixture_ratio1", "readable")
dataref("START_LEVER2", "laminar/B738/engine/mixture_ratio2", "readable")
--  EFIS / LOWER DU
dataref("LOWERDU_PAGE", "laminar/B738/systems/lowerDU_page", "readable") -- 0 off, 1 eng on lower, 2 compact 
dataref("WX_RADAR", "sim/cockpit/switches/EFIS_shows_weather", "readable")
--  FLAPS
dataref("FLAPS", "sim/cockpit2/controls/flap_handle_deploy_ratio", "readable")
dataref("FLAP_LEVER", "laminar/B738/flt_ctrls/flap_lever", "writeable") -- 0 means lever @ UP
dataref("SLATS", "laminar/B738/annunciator/slats_transit", "readable") -- 1 means moving
--  GEAR
dataref("GEAR", "laminar/B738/controls/gear_handle_down", "writeable") -- 0 UP 0.5 OFF 1 DWN
--  ANTI-ICE / PROBES
dataref("EAI1", "laminar/B738/ice/eng1_heat_pos", "writeable")
dataref("EAI2", "laminar/B738/ice/eng2_heat_pos", "writeable")
dataref("PROBE1", "laminar/B738/toggle_switch/capt_probes_pos", "writeable")
dataref("PROBE2", "laminar/B738/toggle_switch/fo_probes_pos", "writeable")
dataref("WAI", "laminar/B738/ice/wing_heat_pos", "writeable")
--  ELECTRICAL
dataref("APU_GEN", "laminar/B738/annunciator/apu_gen_off_bus", "readable") -- 1 means on but not on bus
dataref("GEN1", "laminar/B738/electrical/gen1_pos", "writeable")
dataref("GEN2", "laminar/B738/electrical/gen2_pos", "writeable")
dataref("GPU", "laminar/B738/gpu_available", "readable")
--  AIRCON
dataref("APU_BLEED", "laminar/B738/toggle_switch/bleed_air_apu_pos", "writeable")
dataref("ISOLATIONVALVE", "laminar/B738/air/isolation_valve_pos", "writeable")
dataref("LPACK", "laminar/B738/air/l_pack_pos", "writeable")
dataref("RPACK", "laminar/B738/air/r_pack_pos", "writeable")
--  GENERAL / SIM
dataref("SUNDEG", "sim/graphics/scenery/sun_pitch_degrees", "readable")
dataref("TUG", "bp/connected", "readable")
dataref("X_TEMP", "laminar/B738/systems/temperature/tat_degc", "readable")
dataref("X_RAIN", "sim/weather/rain_percent", "readable")


-- MESSAGE
function MESSAGE()
	if (message_count <= 500 and OPTIONS_VIEWTEXTBUBBLES == true) then
	local pos = 0
	pos = big_bubble(20, pos, message_content)
	message_count = message_count + 1
  end
end

-- PUSH BACK
function PUSH_BACK()
  if (pushback == false and TUG == 1 and PARK_BRAKE == 0 and CHOCKS == 0) then
    pushback = true
    message_content = "Push Back"
    message_count = 1

    command_once("laminar/B738/toggle_switch/seatbelt_sign_dn")
    command_once("laminar/B738/toggle_switch/seatbelt_sign_dn")

    BEACON = 1
    LPACK = 0
    RPACK = 0
    ISOLATIONVALVE = 2
    APU_BLEED = 1
  end
end

function START2()
  if (pushback == true and start2 == false and ENG1_N1 < 18 and ENG2_N1 < 18 and ENG_STARTER1 == 1 and ENG_STARTER2 == 1 and GS > 1) then
    start2 = true
    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_engine2)
    end
    message_content = "Starting 2..."
    message_count = 1

    command_once("laminar/B738/rotary/eng2_start_grd")
  end
end

function START1()
  if (start2 == true and start1 == false and ENG1_N2 < 18 and ENG2_N2 > 18 and ENG_STARTER1 == 1 and ENG_STARTER2 == 1) then
    start1 = true

    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_engine1)
    end

    message_content = "Starting 1..."
    message_count = 1

    command_once("laminar/B738/rotary/eng1_start_grd")
  end
end

-- AFTER START
function AFTER_START()
  if (beforetaxi == false and TAIL == tailcoded and ENG1_N1 > 18 and ENG2_N1 > 18 and AUTOBRAKE_ARM == 1 and ENG_STARTER1 == 1 and ENG_STARTER2 == 1) then 
    beforetaxi = true

    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_checklistcomplete)
    end

    message_content = "After Start"
    message_count = 1

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

    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_taxi)
    end

    message_content = "Taxi"
    message_count = 1

    -- Blank Lower DU
    if (LOWERDU_PAGE == 1) then
    command_once("laminar/B738/LDU_control/push_button/MFD_ENG")
    command_once("laminar/B738/LDU_control/push_button/MFD_ENG")
    elseif (LOWERDU_PAGE == 2) then
    command_once("laminar/B738/LDU_control/push_button/MFD_ENG")
    end

    -- Lights
    command_once("laminar/B738/toggle_switch/taxi_light_brightness_on")
    command_once("laminar/B738/switch/wing_light_on")
    TURNOFF_LEFT = 1
    TURNOFF_RIGHT = 1
  end
end

function TAXI_SPEED()
  if(taxispeedwarning == false and taxi == true and ONGROUND == 1 and GS > 30 and takeoff == false) then
    taxispeedwarning = true

    message_content = "Over 30 knots"
    message_count = 1
    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_taxispeedwarning)
    end
  end
end

-- TAKE OFF
function TAKEOFF()
  if (takeoff == false and TAIL == tailcoded and TOGA == 1) then 
    takeoff = true
    message_content = "Take Off"
    message_count = 1
    command_once("laminar/B738/spring_switch/landing_lights_all")
    command_once("laminar/B738/toggle_switch/position_light_strobe") -- Not accurate as strobes would be on entering runway
  end
end


-- LIFT OFF
function LIFTOFF()
  if (liftoff == false and TAIL == tailcoded and RADALT > 80 and ONGROUND == 0) then
    liftoff = true

    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_liftoff)
    end

    message_content = "Lift Off"
    message_count = 1

    GEAR = 0
    WAI = 0
  end
end

-- AFTER TAKE OFF
function AFTERTAKEOFF()
  if (aftertakeoff == false and TAIL == tailcoded and RADALT > 1000 and ONGROUND == 0 and SLATS == 0 and FLAP_LEVER == 0 and FLAPS == 0 and GEAR == 0 and IAS > UP_SPEED) then 
    aftertakeoff = true

    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_checklistcomplete)
    end

    message_content = "After Take Off"
    message_count = 1

    command_once("laminar/B738/knob/autobrake_off")
    GEAR = 0.5
  end
end

lightsaboveten = false
lightsbelowten = false
-- LIGHTS ABOVE AND BELOW 10,000
function ABOVETENTHOUSAND()
  if (TAIL == tailcoded and ONGROUND == 0 and ALT >10000 and lightsaboveten == false and lightsbelowten == false) then 
    lightsaboveten = true

    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_lightsoff)
    end

    message_content = "Above 10,000'"
    message_count = 1
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
  if (TAIL == tailcoded and ONGROUND == 0 and ALT <10000 and aftertakeoff == true and lightsaboveten == true and lightsbelowten == false) then 
    lightsbelowten = true 

    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_lightson)
    end
    
    message_content = "Below 10,000'"
    message_count = 1
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

-- STABLE APPROACH
function STABLE_APPROACH()
  if(aftertakeoff == true and RADALT < 520 and stableapproach == false) then
    stableapproach = true
    if(IAS <= VREF + OPTIONS_STABLEAPPROACH_SPEEDPOSITIVE and IAS >= VREF + OPTIONS_STABLEAPPROACH_SPEEDMINUS and VSI <= OPTIONS_STABLEAPPROACH_RATEOFDESCENT and OPTIONS_PLAYSOUNDS == true and GEAR == 1 and PARK_BRAKE == 0) then
    play_sound(sound_stable) else
    play_sound(sound_notstable) 
    end
  end
end

-- LANDING
function LANDING_TOUCHDOWN()
  if(ONGROUND == 1 and SPEEDBRAKE_LEVER == 1 and REVERSE == 1 and landing_touchdown == false) then
    landing_touchdown = true
    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_landing) 
    end
  end 
end

function LANDING_SIXTYKNOTS()
  if(ONGROUND == 1 and SPEEDBRAKE_LEVER == 1 and IAS < 65 and landing_sixtyknots == false) then
    landing_sixtyknots = true
    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_sixtyknots)
    end 
  end
end

-- AFTER LANDING
function AFTER_LANDING()
  if (afterlanding == false and TAIL == tailcoded and ONGROUND == 1 and GS < 20 and REVERSE == 0 and aftertakeoff == true) then 
    afterlanding = true   
    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_checklistcomplete)
    end 
    message_content = "Landing"
    message_count = 1

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
    message_content = "Arrive at Gate"
    message_count = 1

    command_once("laminar/B738/toggle_switch/apu_gen2_dn")
    command_once("laminar/B738/toggle_switch/apu_gen1_dn")
  end
end

function SHUT_DOWN()
  if (arriveatgate == true and shutdown == false and TAIL == tailcoded and START_LEVER1 ==0 and START_LEVER2 == 0 and APU_GEN == 0) then
    shutdown = true

    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_checklistcomplete)
    end

    message_content = "Shutdown"
    message_count = 1

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
    EAI1 = 0
    EAI2 = 0
    WAI = 0
    
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

    if (OPTIONS_PLAYSOUNDS) then
    play_sound(sound_endofflight)
    end
    
    message_content = "Beacon"
    message_count = 1

    BEACON = 0
  end
end

-- Run Scripts
do_every_draw("MESSAGE()")

do_often("PUSH_BACK()")
do_often("START1()")
do_often("START2()")
do_often("AFTER_START()")
do_often("TAXI()")
do_often("TAXI_SPEED()")

do_every_draw("TAKEOFF()")
do_every_frame("LIFTOFF()")
do_every_frame("AFTERTAKEOFF()")

do_often("ABOVETENTHOUSAND()")
do_often("BELOWTENTHOUSAND()")

do_often("STABLE_APPROACH()")

do_every_frame("LANDING_TOUCHDOWN()")
do_every_frame("LANDING_SIXTYKNOTS()")
do_often("AFTER_LANDING()")

do_often("AT_GATE()")
do_often("SHUT_DOWN()")
do_often("BEACON_OFF()")