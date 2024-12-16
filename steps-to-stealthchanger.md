# Journey to stealthchanger

## What

[Stealthchanger](https://github.com/DraftShift/StealthChanger) is a toolchanger so multiple tools can be used in the printer. This is significantly faster than multimaterial that uses filament retract and spool rewinds to feed in new filament.

It requires a fairly large amount of modifications (with multiple options) so I thought it'd be nice to write down the ones I did and what my experience was with them.

## Why

It looks cool and it gives me a spare toolhead. I already had a V6 nozzle that I didn't use that came with the kit because I bought the Dragon HF hotend. Being able to print multiple colors way faster than a filament respooler such as ERCF or Box Turtle + having a lot less waste (some colors such as black -> pink really bleed badly into each other needing a lot of purged filament) was a nice bonus. 

## Step by step

### 1. Second toolhead

Building a new toolhead is pretty much the same as building the first toolhead. This time I had to crimp the wires myself instead of using the provided wire loom but it was pretty straight forward. I stuck with what I already knew and bought a SB2209 (RP2040) CAN board with the same MOONS NEMA 14 extruder).
![PXL_20241115_141351774](https://github.com/user-attachments/assets/e375053b-a825-4cb5-a7bc-caaf02314941).

I did buy some shitty fans mostly because I wanted to keep costs down and I didn't know if it would work well. I probably will upgrade to better fans later.

### 2. Docks

I printed and assembled the modular docks from DraftShift Design (the same team behind StealtChanger). Assembling them is pretty straight forward, building the cup filled with RTV silicone was the most annoying and messy part. The wiper to hold the small PTFE tube kept breaking too, but with some superglue and some old laptop screws I managed to get it built.

![PXL_20241118_172505338](https://github.com/user-attachments/assets/9c1f6740-cc41-4b75-96a4-aaee30d31547)

![PXL_20241123_173106999](https://github.com/user-attachments/assets/3ddb172d-2559-4109-809d-b28537ac975a)

When mounting them from the top frame it was pretty evident that it wasn't very stable. With the filament I used they vibrated and flexed around a lot, even with torsion so they weren't fully straight. Trying to fix that with the bolts did not work well, so I ended up adding a crossbar.

There are a couple of options to provide bottom support, a crossbar with a doorbuffer is the easiest, it spaces out the support in front of the frame providing clearance for the gantry idlers. I instead already bought some 2020 extrusions for the top hat to size, so I used a crossbar between the vertical frame. That also meant ripping out the default front idlers and replacing them with [Mini BFI](https://github.com/DraftShift/StealthChanger/tree/main/UserMods/BT123/MiniBFI%20%2B%20MicroBFI) that don't portrude past the frame extrusions

![PXL_20241212_095923227](https://github.com/user-attachments/assets/2fda7d7a-4040-4269-aaa0-8f529973d6d1)

### 3. Sensorless homing

When installing the shuttle there is no X-endstop like there is on the TAP carriage (because otherwise tools wouldn't be able to be detached), so the easiest option is sensorless for X (I ended up doing sensorless for both X and Y). I followed [this](https://github.com/EricZimmerman/VoronTools/blob/main/Sensorless.md) guide and it worked fairly well. The gotcha that got me was that I had to configure TMC autotune as well, otherwise it would work while calibration but fail during normal operation. And it is quite scary home incorrectly and then have the toolhead slam into the gantry. Make sure you calibrate when the gantry isn't level, it adds extra friction so your threshold isn't triggered too soon. 

After installing the shuttle, the belt ends were hindering X homing (and also replacing the umbilicals with stiffer ones) I had to lower the threshold for Stallguard a bit, or it would trigger prematurely so this might need tweaking in the future.

### 4. Faster Z movement

By default the speed is 15mm/s, that is pretty slow to do a tool change. I gradually upped the speed but could not get past 50mm/s. Thinking it was a hardware issue, I checked all the Z-drives grub screws, checked and tensioned all the motor mounts so there is no slack on the big pulley when the motor is initialized (so no backlash), upgraded to [beefy Z idlers (BZI)](https://github.com/clee/VoronBFI/tree/main) and retensioned the belts, but the problem remained. It turned out to be TMC Autotune that put the Z motors in StealthChop and that doesn't work well with higher speeds. Disabling TMC autotune or setting the tuning to performance fixed the issue and I am now running at 100mm/s without a hitch, probably can push it even faster.

### 5. Shuttle

The TAP carriage needs to be replaced with the StealthChanger shuttle. In fact if you put a backplate on a tool and the shuttle on the X rail then everything will still work with the TAP configuration.

I struggled here to print the shuttle belt grooves properly, so I ended up using the shuttle keeper spacer to hold the belts in place and then bolt the shuttle to the keeper and the carriage.

Finding N52 magnets seemed to be hard, I found some on amazon but they were 6.7mm diameter instead of 6mm, which meant I had to make changes to the holes where they are inserted. At this point I've gone through several destroyed shuttles and backplates so this got delayed a lot. I ended up buying N52 magnets from Lecktor and those were 6mm.

![PXL_20241210_082217101](https://github.com/user-attachments/assets/c10d2ce2-286b-47f1-b71f-bdbe27f3d016)

![PXL_20241210_083455271](https://github.com/user-attachments/assets/d89469c1-2214-4e94-a1ce-d763c15568d2)

![PXL_20241210_090507179](https://github.com/user-attachments/assets/e0968ae7-f725-4829-84c7-c3e573e58fe1)

With the help of the belt keeper I tensioned the belts so I didn't even have to use the idlers tension screws much.

### 6. Top hat

Umbilicals are probably the most important in a Stealtchanger build. They need to push the tools into the docks so they sit straight (and they can be picked up well) and don't get yanked off by the weight of the umbilical. In order to have enough clearance for the umbilicals the Z needs to be extended. With the top panel in place on the frame it's impossible to reach the full Z without squishing the umbilical so the solution is a top hat.

Of course if you never print enclosed then it's not necessary but I want to keep ABS and ASA as options.

There are several options, from a printed top hat to using extrusions and polycarbonate panels. For a 350 build it's recommended to have at least 20mm extra in height, which would be a lot of plastic. I switched to a Clicky Clack door earlier so I had the 2 spare 24cm stock doors lying around, so I decided to go with the latter option.

I miscalculated the vertical extrusion length (I ordered 25cm, and received 24cm for some reason), so my vertical height was off to mount the panels in the same way with tough latches as on the frame panels. I created [a spacer](CAD/TopHatSpacer_v2.step) that not only holds the extrusions together but provides extra height so the 24cm panels can sit flush with the bottom.

My extrusions inner diameter are 5mm, while the ones I ordered from the top hat are 6mm. This is annoying as I was planning to use some M5 dowel pins. I ended up designing and printing them instead, [dowelpin](CAD/dowelpin.step), but the top hat extrusions chafe away at them so they are only good for a limited amount of top hat removals before they break.

Another issue I had was that the handles I was using interfere with the top hat panels, I designed and created a [spacer](Voron-1-R-Handle-Spacer.step) for that too. I designed it in such a way that it could be printed standing on its side to provide the best tensile strength.

The top hat is still a work in progress and I still don't have the remaining 2 panels so this might change in the future: TODO

![PXL_20241207_132427544](https://github.com/user-attachments/assets/70af1413-4823-4a93-86b8-c429d841b3a1)

### 7. Umbilicals and CAN wiring

For the actual umbilicals I bought some 1mm spring steel piano wire and used 2 of them next to the CAN cable to provide enough rigidity. A 3mm spring steel strip is recommended nowadays but I didn't have that so I tried to mimic it as best as I could. I used some tape to hold them in place and used some sleeving over it. The first umbilical I didn't put the piano wire all the way to the toolhead and I feel that was a mistake, it bent and pushed the toolhead backwards on the dock. When I extended the piano wire all the way to the toolhead (I use PUG instead of PG7) that worked much better for staying in the docks.

![PXL_20241208_120110282](https://github.com/user-attachments/assets/657b9bcb-e9ad-4ddc-a940-f0cd234ee3e6)

Then I clipped the PTFE tube alongside the umbilicals with some custom designed [cable clips](CableClip-Body001.step) (sized to my umbilical thickness)

![PXL_20241212_154016937](https://github.com/user-attachments/assets/efabc138-f892-4401-b494-5589af3198ec).

Finally the CAN wiring. Initially I had the CAN cable broken out in the electronics bay and used some wago clips, but that meant I also had to run each umbilical downwards, that's not very scalable with more toolheads, so I moved the wagos up near the exhaust and ran 2 1.5mm² power wires along with some leftover CAN cable for the CAN wires, all sleeved together and then attached the umbilicals there.

I still need to print a nice box for it but it works, another TODO.

![PXL_20241212_154946994](https://github.com/user-attachments/assets/542f5100-15c5-498b-a54a-64917d1460cf)

### 8. Configuration

#### Installation 

So far installation and configuration is pretty straight forward, I already defined toolheads in seperate config files, so following the [guide](https://github.com/DraftShift/StealthChanger/wiki/Configuration) was relatively easy.

#### Calibration

One gotcha I had during [dock position calibration](https://github.com/DraftShift/StealthChanger/wiki/Calibration) was that (as of the time of writing) it's still recommended to home, QGL and home again with T0, and then find the positions of the docks (this is not mentioned in the guide). The moment I took T0 off the shuttle the crash protection triggered disabling the motors so it was impossible to try and pick up a tool manually to find its dock position. Running `STOP_TOOL_PROBE_CRASH_DETECTION` is necessary to prevent this. Also when picking up the other tool manually, before testing the docking path make sure you re-run `INITIALIZE_TOOLCHANGER` because otherwise it will think T0 is still active and will try to dock on T0 instead of the correct dock.

For the cups filled with RTV the spring on one was too weak causing it to not contact the nozzle. I added a few washers so it sits higher and that seemed to help but it tilts the toolhead backwards. I've added some M3x12 screws in the docks that correspond to the holes of the M3x50mm screws of the StealthBurner toolhead to prevent to lock it in place. It still tilts back a bit but it can't because the screws are holding it back further. That seemed to work fine. Normally you would add screws the other way and use 5x2mm magnets to lock it in place, but I don't have magnetic screws at the moment. I set it up in the following order: 1) put the tool on the dock 2) adjust the cup height so the nozzle hits the RTV of the cup but not too much it causes too much tilt 3) adjust the back of the dock so the toolhead sits level and doesn't tilt to one side other than backwards 4) do a manual pick up and release with the shuttle and adjust until the toolhead doesn't stray too far off so the pins still go smoothly into the bushings once you pick it up again.

For the Z-offset I initially set up both toolheads, but T1 z-offset is never used (T0 is the reference for homing and every position is based on that). I copied over the z-offset I had before with TAP changer and it worked straight away.

I used a sexball probe which wasn't straight forward to get working. There is quite some play on the shaft so I questioned the accuracy. I had to increase the sample tolerance setting a lot to have it finish. I also ran out of bounds several times as the probe is at the fringe of where the toolhead can be. I had to move the bed backwards a bit so the sexball probe testing range was within bounds. At the same time I also moved the nozzle wiper to the front because that couldn't be reached anymore. So what was a simple crimp wire, mount to extrusion, done turned out to be more of an ordeal. In the end I ran it several times and used the offsets that occurred the most. After test printing that also seemed to be the correct offset.

#### Slicer setup

I use OrcaSlicer and as of v2.2.0 it supports multiple toolheads. Unfortunately you have to set up a whole new printer profile from the Generic Multitool profile to do so (and re-apply all your settings). I've set the idle temp in the filament settings and preheat time in the ooze prevention settings so it drops the temperature when not in use (saving power and squeezing slightly more margin out of the 200W PSU). To ramp them up to idle at the start you can specify those temperaturates along in PRINT_START. Replace M104 with M109 to do them one by one if the PSU is not strong enough.

This is the machine G-Code from OrcaSlicer (credits go to @theaninova on discord):
```
PRINT_START TOOL_TEMP={first_layer_temperature[initial_tool]} {if is_extruder_used[0]}T0_TEMP={first_layer_temperature[0]} T0_IDLE_TEMP={(idle_temperature[0] == 0 ? (first_layer_temperature[0] + standby_temperature_delta) : (idle_temperature[0]))}{endif} {if is_extruder_used[1]}T1_TEMP={first_layer_temperature[1]} T1_IDLE_TEMP={(idle_temperature[1] == 0 ? (first_layer_temperature[1] + standby_temperature_delta) : (idle_temperature[1]))}{endif} {if is_extruder_used[2]}T2_TEMP={first_layer_temperature[2]} T2_IDLE_TEMP={(idle_temperature[2] == 0 ? (first_layer_temperature[2] + standby_temperature_delta) : (idle_temperature[2]))}{endif} {if is_extruder_used[3]}T3_TEMP={first_layer_temperature[3]} T3_IDLE_TEMP={(idle_temperature[3] == 0 ? (first_layer_temperature[3] + standby_temperature_delta) : (idle_temperature[3]))}{endif} {if is_extruder_used[4]}T4_TEMP={first_layer_temperature[4]} T4_IDLE_TEMP={(idle_temperature[4] == 0 ? (first_layer_temperature[4] + standby_temperature_delta) : (idle_temperature[4]))}{endif} {if is_extruder_used[5]}T5_TEMP={first_layer_temperature[5]} T5_IDLE_TEMP={(idle_temperature[5] == 0 ? (first_layer_temperature[5] + standby_temperature_delta) : (idle_temperature[5]))}{endif} BED_TEMP=[first_layer_bed_temperature] TOOL=[initial_tool] CHAMBER_TEMP=[chamber_temperature] FILAMENT=[filament_type]
```

And this is my print start:
```gcode
[gcode_macro PRINT_START]
variable_printing: False
gcode:
  {% set material = params.FILAMENT|default('PLA')|string %} ; Get material type from params
  {% set bedtemp = params.BED_TEMP|default('0')|string %} ; Get the bed temperature
  {% set chambertemp = params.CHAMBER_TEMP|default('0')|string %} ; Get the chamber temperature

  M117 Initializing  
  SET_GCODE_VARIABLE MACRO=PRINT_START VARIABLE=printing VALUE=False
  
  INITIALIZE_TOOLCHANGER
  CHECK_ACTIVE_T0 ; Check T0 is active
  
  SET_DISPLAY_TEXT MSG="Heating the bed to target temperature"
  M190 S{bedtemp} ; heat the bed

  SET_DISPLAY_TEXT MSG="Heating T0 hotend to 150c" 
  M109 S150 ; heat the nozzle
    
  SET_DISPLAY_TEXT MSG="Homing" 
  STATUS_HOMING
  G28
  
  SET_DISPLAY_TEXT MSG="Cleaning nozzle" 
  STATUS_CLEANING
  CLEAN_NOZZLE

  SET_DISPLAY_TEXT MSG="Quad Gantry Leveling" 
  STATUS_LEVELING
  QUAD_GANTRY_LEVEL

  SET_DISPLAY_TEXT MSG="Homing" 
  STATUS_HOMING
  G28

  #SET_DISPLAY_TEXT MSG="Building adaptive bed mesh" 
  #STATUS_MESHING
  #BED_MESH_CALIBRATE ADAPTIVE=1             ; do a bed mesh
  #G1 Z20 F3000                   ; move nozzle away from bed
    
  M109 S0 # Stop to heat, the actual printing may happen with a different hotend.

  SET_DISPLAY_TEXT MSG="Heating up the hotends to idle temp"
  # Preheat all the hotends in use
  {% for tool_nr in printer.toolchanger.tool_numbers %}
    {% set tooltemp_param = 'T' ~ tool_nr|string ~ '_IDLE_TEMP' %}
    {% if tooltemp_param in params %}
      M104 T{tool_nr} S{params[tooltemp_param]}
    {% endif %}
  {% endfor %}

  SET_DISPLAY_TEXT MSG="Switching to active tool" 
  {% if params.TOOL is defined %}
    T{params.TOOL}
  {% endif %}

  SET_DISPLAY_TEXT MSG="Heating hotend to target temp" 
  M109 S{ params.TOOL_TEMP }
  G0 Z2 F300 ;Move up a bit
  G92 E0 ; Zero extruder
  
  START_TOOL_PROBE_CRASH_DETECTION
  SET_GCODE_VARIABLE MACRO=PRINT_START VARIABLE=printing VALUE=True
  
  SET_DISPLAY_TEXT MSG="Cleaning nozzle ooze" 
  STATUS_CLEANING
  CLEAN_NOZZLE ; clean the nozzle to remove and leftover ooze
    
  SET_MATERIAL MATERIAL={material} ; setup the things specific for the material
    
  SET_DISPLAY_TEXT MSG="Printing" 
  STATUS_PRINTING  
  
#####################################
##            Set Material         ##
##      Version 1.0  2023-4-2      ##
#####################################
## From: https://github.com/rootiest/zippy-klipper_config
## Set Material-specific Configs
## 
## Add this immediately after your start_print line of the start gcode in Prusa/SuperSlicer:
##     SET_MATERIAL MATERIAL='{filament_type[initial_extruder]}'
## 
## Add this immediately after your start_print line of the start gcode in Cura:
##     SET_MATERIAL MATERIAL='{material_type}'
## 
[gcode_macro SET_MATERIAL]
description: Set values based on material type
variable_material: ''
gcode:
    {% set material = params.MATERIAL|default('PLA')|string %} ; Get material type from slicer
    {% if material == 'PLA' %} ; If material type is PLA
        SET_FAN_SPEED FAN=nevermore_fan SPEED=0.0
    {% elif material == 'ABS' %} ; If material type is ABS
        SET_FAN_SPEED FAN=nevermore_fan SPEED=1.0
    {% elif material == 'ASA' %} ; If material type is ASA
        SET_FAN_SPEED FAN=nevermore_fan SPEED=1.0
    {%else %} ; If any other material type
        SET_FAN_SPEED FAN=nevermore_fan SPEED=0.0
    {% endif %}
```

I had the pressure advance settings per filament in the SET_MATERIAL, but I moved that to the filament settings in OrcaSlicer because it emits a SET_PRESSURE_ADVANCE at every filament change.

One issue I had was that it took a long time for the temperature to settle, even with long preheat time it often caused delays at tool swaps. OrcaSlicer emits M109 at every filament change when using ooze prevention, the default M109 waits until it's stable within 0.5 degrees which is too precise.
There is already an override from TAP changer, but this override from DSD is better as it allows you to set the deadband, so rather than a 0.5° it now uses a 3° variance for stability. This still needs to be tweaked depending on the hotend. My Dragon HF stabilizes much quicker than the cheap V6 nozzle.
```

[gcode_macro M109]
rename_existing: M109.1
description: [T<index>] [S<temperature>] [D<Deadband>]
  Set tool temperature and wait.
  T= Tool number [optional]. If this parameter is not provided, the current tool is used.
  S= Target temperature
  D= Dead-band, allows the temperature variance +/- the deadband
variable_default_deadband: 6.0
gcode:
    {% set s = params.S|float %}
    {% set deadband = default_deadband|float %}
    {% if params.D is defined %}
        {% set deadband = params.D|float %}
    {% endif %}
    {% set tn = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    {% set tool = printer.toolchanger.tool_names[tn]|default('') %}
    {% set extruder = printer[tool].extruder %}

    SET_HEATER_TEMPERATURE HEATER={extruder} TARGET={s}
    {% if s > 0 %}
        TEMPERATURE_WAIT SENSOR={extruder} MINIMUM={s-(deadband/2)} MAXIMUM={s+(deadband/2)}   ; Wait for hotend temp (within D degrees)
    {% endif %}
```

### 9. Test print

I created some cubes in Orca, positioned them next to each other, changed their height to 1mm and set each one to a different tool. That allowed me to see if the calculated Z-offset of T1 is good (based off the gcode z offset) and to see if the X and Y are aligned (to test the gcode x and y offsets). It also is a good test for tool changes.

After doing a longer print with 108 tool changes it's probably good to inspect what else needs adjusting and what broke. I needed to adjust the cup as mentioned to prevent ooze and my wiper on one toolhead broke. The PUG on one toolhead also broke because the umbilical keeps getting snagged under the frame until it violently rebounds. During the print the prime tower also lifted from the bed so more brim was required.

![PXL_20241215_171907459](https://github.com/user-attachments/assets/8667748b-4191-46e3-acdf-00517bffa993)


