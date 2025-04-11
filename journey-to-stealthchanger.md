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

I printed and assembled the modular docks from DraftShift Design (the same team behind StealthChanger). Assembling them is pretty straight forward, building the cup filled with RTV silicone was the most annoying and messy part. The wiper to hold the small PTFE tube kept breaking too, but with some superglue and some old laptop screws I managed to get it built.

![PXL_20241118_172505338](https://github.com/user-attachments/assets/9c1f6740-cc41-4b75-96a4-aaee30d31547)

![PXL_20241123_173106999](https://github.com/user-attachments/assets/3ddb172d-2559-4109-809d-b28537ac975a)

When mounting them from the top frame it was pretty evident that it wasn't very stable. With the filament I used they vibrated and flexed around a lot, even with torsion so they weren't fully straight. Trying to fix that with the bolts did not work well, so I ended up adding a crossbar.

There are a couple of options to provide bottom support, a crossbar with a doorbuffer is the easiest, it spaces out the support in front of the frame providing clearance for the gantry idlers. I instead already bought some 2020 extrusions for the top hat to size, so I used a crossbar between the vertical frame. That also meant ripping out the default front idlers and replacing them with [Mini BFI](https://github.com/DraftShift/StealthChanger/tree/main/UserMods/BT123/MiniBFI%20%2B%20MicroBFI) that don't portrude past the frame extrusions

![PXL_20241212_095923227](https://github.com/user-attachments/assets/2fda7d7a-4040-4269-aaa0-8f529973d6d1)

I ended up redoing the docks removing the top support with [Crabby docks](https://www.printables.com/model/994635-stealthchanger-stealthburner-minimal-docks-aka-hap). It looks nicer and doesn't obscure as much
![PXL_20250101_112623563](https://github.com/user-attachments/assets/9d3291cd-da54-44f9-9349-02b0e5895c78)

Rather than using magnets to lock the tools in I'm using screws with PTFE tube over them. That secures the tools so much in their docks I can put the whole printer on its side and they will stay put. I tried with 5x2mm magnets but they were not powerful enough to keep the tool in place and it limits the tilt enough that I could reduce the umbilical length, which in turn helped with umbilicals not getting stuck under each other

![PXL_20250102_114548267](https://github.com/user-attachments/assets/ecdf5828-476f-4046-8bb0-8c27d4ad3cf3)

### 3. Sensorless homing

When installing the shuttle there is no X-endstop like there is on the TAP carriage (because otherwise tools wouldn't be able to be detached), so the easiest option is sensorless for X (I ended up doing sensorless for both X and Y). I followed [this](https://github.com/EricZimmerman/VoronTools/blob/main/Sensorless.md) guide and it worked fairly well. The gotcha that got me was that I had to configure TMC autotune as well, otherwise it would work while calibration but fail during normal operation. And it is quite scary home incorrectly and then have the toolhead slam into the gantry. Make sure you calibrate when the gantry isn't level, it adds extra friction so your threshold isn't triggered too soon. 

After installing the shuttle, the belt ends were hindering X homing (and also replacing the umbilicals with stiffer ones) I had to lower the threshold for Stallguard a bit, or it would trigger prematurely so this might need tweaking in the future.

### 4. Faster Z movement

By default the speed is 15mm/s, that is pretty slow to do a tool change. I gradually upped the speed but could not get past 50mm/s. Thinking it was a hardware issue, I checked all the Z-drives grub screws, checked and tensioned all the motor mounts so there is no slack on the big pulley when the motor is initialized (so no backlash), upgraded to [beefy Z idlers (BZI)](https://github.com/clee/VoronBFI/tree/main) and retensioned the belts, but the problem remained. It turned out to be TMC Autotune that put the Z motors in StealthChop and that doesn't work well with higher speeds. Disabling TMC autotune or setting the tuning to performance fixed the issue and I am now running at 100mm/s without a hitch, probably can push it even faster.

### 5. Shuttle

The TAP carriage needs to be replaced with the StealthChanger shuttle. In fact if you put a backplate on a tool and the shuttle on the X rail then everything will still work with the TAP configuration. I ran this for quite some time, this is how I gradually converted my printer to Stealthchanger without losing the ability to print while doing so.

I struggled here to print the shuttle belt grooves properly, so I ended up using the shuttle keeper spacer to hold the belts in place and then bolt the shuttle to the keeper and the carriage.

Finding N52 magnets seemed to be hard, I found some on amazon but they were 6.7mm diameter instead of 6mm, which meant I had to make changes to the holes where they are inserted. At this point I've gone through several destroyed shuttles and backplates so this got delayed a lot. I ended up buying N52 magnets from Lecktor and those were 6mm.

![PXL_20241210_082217101](https://github.com/user-attachments/assets/c10d2ce2-286b-47f1-b71f-bdbe27f3d016)

![PXL_20241210_083455271](https://github.com/user-attachments/assets/d89469c1-2214-4e94-a1ce-d763c15568d2)

![PXL_20241210_090507179](https://github.com/user-attachments/assets/e0968ae7-f725-4829-84c7-c3e573e58fe1)

With the help of the belt keeper I tensioned the belts so I didn't even have to use the idlers tension screws much.

I didn't have any issue mating the shuttle with the backplate, I first installed the bushings in the shuttle and glued them in place. I cracked several shuttles trying to insert the bushings (don't use eSun ABS+ for a shuttle). One shuttle ended up cracking when I bolted it to the carriage, which caused the bushings to have too much play and not trigger the Octotap sensor anymore.

My octotap sensors combined with my printed shuttles are very sensitive to slight deviations in angle, so while I initially just extended the shuttle tip by gluing a piece of filament on top so it triggers octotap more reliably it was really solving a problem whose cause would have other issues as well. So my latest attempt that seems to work well is:

 - Install bushings in shuttle, glue them in place so they can't move around and flex
 - Install magnets in the shuttle. Make sure to fit them in first before adding glue because mine set too quickly and caused one of the magnets to not fully seat *sigh*. Tolerances 🙄
 - Mate with a backplate so the pins are aligned to the bushings, glue the pins in place and let it dry while mated with the shuttle, that ensures they stay aligned
 - Add the magnet in the backplate, make sure of the correct polarity, glue it in place after fitting them first
 - Add and adjust the preload screws of the backplate, first screwing them fully in and then back them out by half or quarter turns each. Too far and the octotap won't trigger anymore, not far enough and there will be too much play. When putting the toolhead on the shuttle there should be absolutely no side to side play (rotation around the Y axis), if there is probe accuracy will suffer. Adjust the preload screws until there is none.

Those N52 magnets are strong, make sure to use enough glue, I didn't at first and they got loose after a while causing probe accuracy issues and eventually tool changes to fail. I also had my nozzles dragging over the print during fast travel moves.

After doing that I have good probe accuracy and no issue with tool changes.

In fact to troubleshoot probe accuracy I now check:
 - Loose screws anywhere? Shuttle screws, backplate screws, octotap screws?
 - Are the magnets still sitting flush? Are they loose in either shuttle or backplate?
 - Is there play in the toolhead? Check preload screws and adjust
 - Is there wiggle room in the bushings or pins of the backplate?
 - Are there any cracks in the shuttle, especially near the top bushings. Again really don't use eSun ABS+, layer adhesion is horrible.
 - Are the bushings still securely glued in place?
 - Check for warpage of the hotend/backplate, shim if necessary so the nozzle is perpendicular to the bed
![PXL_20250101_100158564](https://github.com/user-attachments/assets/11b9c7c1-c9d0-4354-b9cb-33ba61ea84b8) (this isn't very straight anymore :|)

Any of these things will cause probe accuracy, z-offset inaccuracies and potential docking issues.

*Update April 2025* After some weeks of printing it becare clear that CA superglue is *not* good enough to keep the magnets in place, I've had several failures of both backplates and shuttle where the magnet popped out and then rode along so it couldn't tool change anymore. I've been recommended to use 2 component epoxy glue to secure them or use [6x3 with 2mm ID screw in magnets with M2 self tapping screws](https://discord.com/channels/1226846451028725821/1226846451594821707/1359884602902052894) to secure them into the plastic.

### 6. Top hat

Umbilicals are probably the most important in a StealthChanger build. They need to push the tools into the docks so they sit straight (and they can be picked up well) and don't get yanked off by the weight of the umbilical. In order to have enough clearance for the umbilicals the Z needs to be extended. With the top panel in place on the frame it's impossible to reach the full Z without squishing the umbilical so the solution is a top hat.

I wanted to keep ABS and ASA as options so keeping the printing enclosed was mandatory.

There are several options, from a printed top hat to using extrusions and polycarbonate panels. For a 350 build it's recommended to have at least 20mm extra in height, which would be a lot of plastic. I switched to a Clicky Clack door earlier so I had the 2 spare 24cm stock doors lying around, so I decided to go with the latter option.

I miscalculated the vertical extrusion length (I ordered 25cm, and received 24cm for some reason), so my vertical height was off to mount the panels in the same way with tough latches as on the frame panels. I created [a spacer](CAD/TopHatSpacer_v2.step) that not only holds the extrusions together but provides extra height so the 24cm panels can sit flush with the bottom.

My extrusions inner diameter are 5mm, while the ones I ordered from the top hat are 6mm. This is annoying as I was planning to use some M5 dowel pins. I ended up designing and printing them instead, [dowelpin](CAD/dowelpin.step), but the top hat extrusions chafe away at them so they are only good for a limited amount of top hat removals before they break.

Another issue I had was that the handles I was using interfere with the top hat panels, I designed and created a [spacer](Voron-1-R-Handle-Spacer.step) for that too. I designed it in such a way that it could be printed standing on its side to provide the best tensile strength.

![PXL_20250121_143938197](https://github.com/user-attachments/assets/df42d49f-b97f-4365-b98c-25a239750f7d)

Not having an extrusion for the front of the top hat (it's used as crossbar) is a bit annoying to have a tight seal, but the weatherseal strip seems to work alright. Unfortunately my panels were not cut to 0.1mm tolerances, like 0.5mm too tall, which is giving me issues to put panel clamps on the top. I've instead added more on the side to increase friction so it stays put.

Unfortunately it didn't do much for keeping the chamber temperature high for ABS printing, I barely get above 40° C and that's with The Filter + side filters (4 blower fans) at full blast.


### 7. Umbilicals and CAN wiring

For the actual umbilicals I bought some 1mm spring steel piano wire and used 2 of them next to the CAN cable to provide enough rigidity. A 3mm spring steel strip is recommended nowadays but I didn't have that so I tried to mimic it as best as I could. I used some tape to hold them in place and used some sleeving over it. The first umbilical I didn't put the piano wire all the way to the toolhead and I feel that was a mistake, it bent and pushed the toolhead backwards on the dock. When I extended the piano wire all the way to the toolhead (I use PUG instead of PG7) that worked much better for staying in the docks.

One thing I had to make sure was that the natural curl the piano wires wanted to make aligned with the arc that I wanted the umbilical to make, so i had to clamp them down at the toolhead in the PUG in exactly the right orientation and the same at the PG7 gland at the exhaust.

I used the [umbilical exhaust by N3MI](https://github.com/DraftShift/CableManagement/tree/main/UserMods/N3MI-DG/Umbilical_Plates) to attach the exhausts at the back. I had a lot of trouble getting the PG7 glands to screw in. I initially thought I probably need to tune shrinkage and hole compensation settings more but after buying some new PG7 glands those fit perfectly, so the ones I got with the Formbot kit were out of spec.

Determining the length of the umbilical was not that easy. The docks in the corners need a slightly longer one to make the same arc. Mine are about 70cm but I feel that's still too long. It's a lot of testing that the toolhead doesn't get yanked backwards but also that the front corners can be reached without putting too much strain on the umbilical.

After some tweaking 60cm is a better length, with a longer length they often got stuck underneath each other and they tended to flop more to the side, with 60cm they don't interfere with each other anymore even though they pull the tool backwards more but the tilt is limited by having the physical screws on the docks to lock the tools in place. Too much tilt would prevent correct alignment of the backplate pins with the shuttle so those docks screws are very mandatory with a shorter umbilical.


![PXL_20241208_120110282](https://github.com/user-attachments/assets/657b9bcb-e9ad-4ddc-a940-f0cd234ee3e6)

Then I clipped the reverse bowden tube alongside the umbilicals with some custom designed [cable clips](CableClip-Body001.step) (sized to my umbilical thickness)

![PXL_20241212_154016937](https://github.com/user-attachments/assets/efabc138-f892-4401-b494-5589af3198ec).

Finally the CAN wiring. Initially I had the CAN cable broken out in the electronics bay and used some wago clips, but that meant I also had to run each umbilical downwards, that's not very scalable with more toolheads, so I moved the wagos up near the exhaust and ran 2 1.5mm² power wires along with some leftover CAN cable for the CAN wires, all sleeved together and then attached the umbilicals there.

![PXL_20241212_154946994](https://github.com/user-attachments/assets/542f5100-15c5-498b-a54a-64917d1460cf)

I've designed [a box](https://www.printables.com/model/1119606-wago-can-distribution-box-for-n3mi-umbilical-plate) to make it neater.

![image](https://github.com/user-attachments/assets/cb25afbf-55b7-483d-a81a-d7987f48c784)

![image](https://github.com/user-attachments/assets/8b940755-d5db-489d-b8d2-50773141c6c4)

### 8. Configuration

#### Installation 

So far installation and configuration is pretty straight forward, I already defined toolheads in seperate config files, so following the [guide](https://github.com/DraftShift/StealthChanger/wiki/Configuration) was relatively easy. Make sure to use the [easy config](https://github.com/jwellman80/klipper-toolchanger-easy) by @averen or use the klipper-toolchanger from June 2024 because newer commits have broken stealthchanger. There is a DSD fork in the works that will bring everything together but right now it's still in alpha and I have not used it yet.

#### Calibration

One gotcha I had during [dock position calibration](https://github.com/DraftShift/StealthChanger/wiki/Calibration) was that (as of the time of writing) it's still recommended to home, QGL and home again with T0, and then find the positions of the docks (this is not mentioned in the guide). The moment I took T0 off the shuttle the crash protection triggered disabling the motors so it was impossible to try and pick up a tool manually to find its dock position. Running `STOP_TOOL_PROBE_CRASH_DETECTION` is necessary to prevent this. Also when picking up the other tool manually, before testing the docking path make sure you re-run `INITIALIZE_TOOLCHANGER` because otherwise it will think T0 is still active and will try to dock on T0 instead of the correct dock (as I found out the hard way).

For the cups filled with RTV the spring on one was too weak causing it to not contact the nozzle. I added a few washers so it sits higher and that seemed to help but it tilts the toolhead backwards. I've added some M3x12 screws in the docks that correspond to the holes of the M3x50mm screws of the StealthBurner toolhead to prevent to lock it in place. It still tilts back a bit but it can't because the screws are holding it back further. That seemed to work fine. Normally you would add screws the other way and use 5x2mm magnets to lock it in place, but I don't have magnetic screws at the moment. I set it up in the following order: 1) put the tool on the dock 2) adjust the cup height so the nozzle hits the RTV of the cup but not too much it causes too much tilt 3) adjust the back of the dock so the toolhead sits level and doesn't tilt to one side other than backwards 4) do a manual pick up and release with the shuttle and adjust until the toolhead doesn't stray too far off so the pins still go smoothly into the bushings once you pick it up again.

For the Z-offset I initially set up both toolheads, but T1 z-offset is never used (T0 is the reference for homing and every position is based on that). I copied over the z-offset I had before with TAP changer and it worked straight away.

I used a sexball probe which wasn't straight forward to get working. There is quite some play on the shaft so I questioned the accuracy. I had to increase the sample tolerance setting a lot to have it finish. I also ran out of bounds several times as the probe is at the fringe of where the toolhead can be. I had to move the bed backwards a bit so the sexball probe testing range was within bounds. At the same time I also moved the nozzle wiper to the front because that couldn't be reached anymore. So what was a simple crimp wire, mount to extrusion, done turned out to be more of an ordeal. In the end I ran it several times and used the offsets that occurred the most. After test printing that also seemed to be the correct offset.

#### Slicer setup

I use OrcaSlicer and as of v2.2.0 it supports multiple toolheads. Unfortunately I had to set up a whole new printer profile from the Generic Multitool profile to do so (and re-apply all my settings). I've set the idle temp in the filament settings and preheat time in the ooze prevention settings so it drops the temperature when not in use (saving power and squeezing slightly more margin out of the 200W PSU). To ramp them up to idle at the start I specified those temperaturates along in PRINT_START. Replace M104 with M109 to do them one by one if the PSU is not strong enough.

This is the machine G-Code from OrcaSlicer (credits go to @theaninova on discord):
```
PRINT_START TOOL_TEMP={first_layer_temperature[initial_tool]} {if is_extruder_used[0]}T0_TEMP={first_layer_temperature[0]} T0_IDLE_TEMP={(idle_temperature[0] == 0 ? (first_layer_temperature[0] + standby_temperature_delta) : (idle_temperature[0]))}{endif} {if is_extruder_used[1]}T1_TEMP={first_layer_temperature[1]} T1_IDLE_TEMP={(idle_temperature[1] == 0 ? (first_layer_temperature[1] + standby_temperature_delta) : (idle_temperature[1]))}{endif} {if is_extruder_used[2]}T2_TEMP={first_layer_temperature[2]} T2_IDLE_TEMP={(idle_temperature[2] == 0 ? (first_layer_temperature[2] + standby_temperature_delta) : (idle_temperature[2]))}{endif} {if is_extruder_used[3]}T3_TEMP={first_layer_temperature[3]} T3_IDLE_TEMP={(idle_temperature[3] == 0 ? (first_layer_temperature[3] + standby_temperature_delta) : (idle_temperature[3]))}{endif} {if is_extruder_used[4]}T4_TEMP={first_layer_temperature[4]} T4_IDLE_TEMP={(idle_temperature[4] == 0 ? (first_layer_temperature[4] + standby_temperature_delta) : (idle_temperature[4]))}{endif} {if is_extruder_used[5]}T5_TEMP={first_layer_temperature[5]} T5_IDLE_TEMP={(idle_temperature[5] == 0 ? (first_layer_temperature[5] + standby_temperature_delta) : (idle_temperature[5]))}{endif} BED_TEMP=[first_layer_bed_temperature] TOOL=[initial_tool] CHAMBER_TEMP=[chamber_temperature] FILAMENT=[filament_type]
```

And this is my print start:
```gcode
[gcode_macro PRINT_START]
variable_printing: False
variable_tools_used_during_print: []
gcode:
  {% set material = params.FILAMENT|default('PLA')|string %} ; Get material type from params
  {% set bedtemp = params.BED_TEMP|default('0')|string %} ; Get the bed temperature
  {% set chambertemp = params.CHAMBER_TEMP|default('0')|string %} ; Get the chamber temperature
  
  M117 Initializing  
  SET_GCODE_VARIABLE MACRO=PRINT_START VARIABLE=printing VALUE=False

  # Register the tools used during print
  {% set tools_used_during_print = [] %}
  {% for tool_nr in printer.toolchanger.tool_numbers %}
    {% set tooltemp_param = 'T' ~ tool_nr|string ~ '_TEMP' %}
    {% if tooltemp_param in params %}
      {% set _ = tools_used_during_print.append(tool_nr) %}
      SET_GCODE_VARIABLE macro=PRINT_START variable=tools_used_during_print value="{tools_used_during_print}"
    {% endif %}
  {% endfor %}
  RESPOND TYPE='echo' MSG="The print uses the following tools: {tools_used_during_print|join(' ')}. M104 will be ignored for all other tools while the print is active"

  
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

  SET_DISPLAY_TEXT MSG="Building adaptive bed mesh" 
  STATUS_MESHING
  BED_MESH_CALIBRATE ADAPTIVE=1             ; do a bed mesh
  G1 Z20 F3000                   ; move nozzle away from bed
    
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

To make sure T0 is active I used the following gcode. Using any other tool to home and QGL is going to cause issues with z-offset and docking:
```
[gcode_macro CHECK_ACTIVE_T0]
gcode:
  {% set tool = printer[printer.toolchanger.tool].tool_number %}
  {% if tool != 0 %}
    {% set msg = 'T0 is not active, active tool is ' ~ tool|string ~ '. Cancelling print.' %}
    SET_DISPLAY_TEXT MSG="{msg}"
    RESPOND TYPE=error MSG="{msg}"
    CANCEL_PRINT
  {% endif %}
```

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
#### Workaround for an annoying [bug](https://github.com/SoftFever/OrcaSlicer/issues/7842) in OrcaSlicer 2.2.0

*Note: OrcaSlicer 2.3.0 is out where this is fixed so this is now not necessary anymore*

When printing single color on any toolhead other than T0, it still preheats T0 for some reason, and it does so multiple times so just setting it to 0° does not work for long. I worked around that by keeping track of the tools that are used in PRINT_START (see '#Register the tools used during print' above) and then check if the M104 call to heat a toolhead is in that list:
```gcode
[gcode_macro M104]
rename_existing: M104.1
description: [T<index>] [S<temperature>]
  Set tool temperature.
  T= Tool number, optional. If this parameter is not provided, the current tool is used.
  S= Target temperature
gcode:
  {% if params.T is defined %}

     {% set can_change_temp = False %}
     {% if printer["gcode_macro PRINT_START"].printing %}
      {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
      {% set tools_used = printer["gcode_macro PRINT_START"].tools_used_during_print %}
      
      {% if tool_nr in tools_used %}
        #RESPOND TYPE=echo MSG="Tool {tool_nr} is used in print, can set temp to requested tool"  
        {% set can_change_temp = True %}
      {% else %}
        RESPOND TYPE=echo MSG="Tool {tool_nr} is not used in print, ignoring request for M104"
      {% endif %}
    {% else %}
      #RESPOND TYPE=echo MSG="Not printing, can set temp to requested tool {tool_nr}"
      {% set can_change_temp = True %}
    {% endif %}

    {% if can_change_temp %}
      {% set newparameters = "" %}
      {% set newparameters = newparameters ~ " T="~params.T %}
      {% if params.S is defined %}
        {% set newparameters = newparameters ~ " TARGET="~params.S %}
      {% endif %}
      SET_TOOL_TEMPERATURE{newparameters}
    {% endif %}
    
  {% else %}
    M104.1 {rawparams}
  {% endif %}
```


### 9. Test print

I created some cubes in Orca, positioned them next to each other, changed their height to 1mm and set each one to a different tool. That allowed me to see if the calculated Z-offset of T1 is good (based off the gcode z offset) and to see if the X and Y are aligned (to test the gcode x and y offsets). It also is a good test for tool changes. This one is with 3 tools:

![PXL_20250102_185223868](https://github.com/user-attachments/assets/a8dbebc1-42f4-4445-9ea4-04be8e030880)

After doing a longer print with 108 tool changes it's probably good to inspect what else needs adjusting and what broke. I needed to adjust the cup as mentioned to prevent ooze and my wiper on one toolhead broke. The PUG on one toolhead also broke because the umbilical keeps getting snagged under the frame until it violently rebounds. During the print the prime tower also lifted from the bed so more brim was required.

![PXL_20241215_171907459](https://github.com/user-attachments/assets/8667748b-4191-46e3-acdf-00517bffa993)

### 10. LED Config for multiple toolheads

Initially I was going to go for [klipper-led-effect](https://github.com/julianschill/klipper-led_effect) and set that up with a working configuration, but unfortunately I got way too many Timer Too Close (TTC) errors during homing/QGL. The CB1 is just not fast enough to process the extra CAN messages in time. I defined the effects per toolhead with a _tN suffix, where N is the tool number and then in all the STATUS_xxxx macros added the suffix based on the current tool (or given T=xx).

I did the same with the static stealthburner_leds.cfg:

```
# Macros for setting the status leds on the Voron StealthBurner toolhead (or for any neopixel-type leds).
#
# You will need to configure a neopixel (or other addressable led, such as dotstar). See
# https://www.klipper3d.org/Config_Reference.html#neopixel for configuration details.


#####################################
#           INSTRUCTIONS            #
#####################################
# How to use all this stuff:
#
#     1.  Copy this .cfg file into your Klipper config directory and then add [include stealthburner_leds.cfg]
#         to the top of your printer.cfg in order to register the LEDs and macros with Klipper.
#     2.  Define your LEDs by editing [neopixel sb_leds] below and entering the data pin from your control board
#         as well as the color order.
#
#           Note: RGB and RGBW are different and must be defined explicitly.  RGB and RGBW are also not able to 
#                 be mix-and-matched in the same chain. A separate data line would be needed for proper functioning.
#
#                 RGBW LEDs will have a visible yellow-ish phosphor section to the chip.  If your LEDs do not have
#                 this yellow portion, you have RGB LEDs.
#
#     3.  Save your config and restart Klipper.
#
#           Note: We set RED and BLUE to 1.0 to make it easier for users and supporters to detect 
#                 misconfigurations or miswiring. The default color format is for Neopixels with a dedicated 
#                 white LED. On startup, all three SB LEDs should light up.
#
#                 If you get random colors across your LEDs, change the color_order to GRB and restart. Then
#                 omit the W for each suggested color_order in the next paragraph.
#
#                 If you get MAGENTA, your  color order is correct. If you get CYAN, you need to use RGBW. If
#                 you get YELLOW, you need to use BRGW (note that BRG is only supported in the latest Klipper
#                 version).
#
#     4.  Once you have confirmed that the LEDs are set up correctly, you must now decide where you want 
#         these macros called up...which means adding them to your existing gcode macros.  NOTHING will happen
#         unless you add the STATUS_????? macros to your existing gcode macros.  
#
#           Example: add STATUS_LEVELING to the beginning of your QGL gcode macro, and then add STATUS_READY 
#                    to the end of it to set the logo LED and nozzle LEDs back to the `ready` state.
#
#           Example: add STATUS_CLEANING to the beginning of your nozzle-cleaning macro, and then STATUS_READY
#                    to the end of it to return the LEDs back to `ready` state.
#
#     5.  Feel free to change colors of each macro, create new ones if you have a need to.  The macros provided below
#         are just an example of what is possible.  If you want to try some more complex animations, you will most
#         likely have to use WLED with Moonraker and a small micro-controller 
#
#####################################
#       END INSTRUCTRUCTIONS        #
#####################################

##########
# MACROS #
##########

# The following status macros are available (these go inside of your macros):
#
#    STATUS_READY
#    STATUS_OFF
#    STATUS_BUSY
#    STATUS_HEATING
#    STATUS_LEVELING
#    STATUS_HOMING
#    STATUS_CLEANING
#    STATUS_MESHING
#    STATUS_CALIBRATING_Z
#
# With additional macros for basic control:
#
#    SET_NOZZLE_LEDS_ON
#    SET_LOGO_LEDS_OFF
#    SET_NOZZLE_LEDS_OFF
#
# Contributed by Voron discord users wile.e, Tetsunosuke, and etherwalker


[gcode_macro _sb_vars]
# User settings for the StealthBurner status leds. You can change the status colors and led
# configurations for the logo and nozzle here.
variable_colors: {
        'logo': { # Colors for logo states
            'busy': {'r': 0.4, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'cleaning': {'r': 0.0, 'g': 0.02, 'b': 0.5, 'w': 0.0},
            'calibrating_z': {'r': 0.8, 'g': 0., 'b': 0.35, 'w': 0.0},
            'heating': {'r': 0.3, 'g': 0.18, 'b': 0.0, 'w': 0.0},
            'homing': {'r': 0.0, 'g': 0.6, 'b': 0.2, 'w': 0.0},
            'leveling': {'r': 0.5, 'g': 0.1, 'b': 0.4, 'w': 0.0},
            'meshing': {'r': 0.2, 'g': 1.0, 'b': 0.0, 'w': 0.0},
            'off': {'r': 0.0, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'printing': {'r': 1.0, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'standby': {'r': 0.01, 'g': 0.01, 'b': 0.01, 'w': 0.1},
            'docking': {'r': 1.0, 'g': 1.0, 'b': 0.0, 'w': 0.0},
        },
        'nozzle': { # Colors for nozzle states
            'heating': {'r': 0.8, 'g': 0.35, 'b': 0.0, 'w':0.0},
            'off': {'r': 0.0, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'on': {'r': 0.8, 'g': 0.8, 'b': 0.8, 'w':1.0},
            'standby': {'r': 0.6, 'g': 0.0, 'b': 0.0, 'w':0.0},
        },
        'thermal': {
            'hot': {'r': 1.0, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'cold': {'r': 0.3, 'g': 0.0, 'b': 0.3, 'w': 0.0}
        }
    }
variable_logo_led_name:         "sb_leds" 
# The name of the addressable LED chain that contains the logo LED(s)
variable_logo_idx:              "1" 
# A comma-separated list of indexes LEDs in the logo
variable_nozzle_led_name:       "sb_leds"
# The name of the addressable LED chain that contains the nozzle LED(s). This will
# typically be the same LED chain as the logo.
variable_nozzle_idx:            "2,3"
# A comma-separated list of indexes of LEDs in the nozzle
gcode:
    # This section is required.  Do Not Delete.


[gcode_macro _set_sb_leds]
gcode:
    {% set red = params.RED|default(0)|float %}
    {% set green = params.GREEN|default(0)|float %}
    {% set blue = params.BLUE|default(0)|float %}
    {% set white = params.WHITE|default(0)|float %}
    {% set led = params.LED|string %}
    {% set idx = (params.IDX|string).split(',') %}
    {% set transmit_last = params.TRANSMIT|default(1) %}

    {% for led_index in idx %}
        {% set transmit=transmit_last if loop.last else 0 %}
        set_led led={led} red={red} green={green} blue={blue} white={white} index={led_index} transmit={transmit}
        #RESPOND TYPE='echo' MSG="Setting led {led}, index {led_index} with {red},{green},{blue},{white}, transmit={transmit}"
    {% endfor %}

[gcode_macro _set_sb_leds_by_name]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    {% set leds_name = params.LEDS %}
    {% set color_name = params.COLOR %}
    {% set color = printer["gcode_macro _sb_vars"].colors[leds_name][color_name] %}
    {% set led = printer["gcode_macro _sb_vars"][leds_name + "_led_name"] ~ "_t" ~ tool_nr|string %}
    {% set idx = printer["gcode_macro _sb_vars"][leds_name + "_idx"] %}
    {% set transmit = params.TRANSMIT|default(1) %}

    _set_sb_leds led={led} red={color.r} green={color.g} blue={color.b} white={color.w} idx="{idx}" transmit={transmit}

[gcode_macro _set_logo_leds]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    {% set red = params.RED|default(0)|float %}
    {% set green = params.GREEN|default(0)|float %}
    {% set blue = params.BLUE|default(0)|float %}
    {% set white = params.WHITE|default(0)|float %}
    {% set led = printer["gcode_macro _sb_vars"].logo_led_name  ~ "_t" ~ tool_nr|string %}
    {% set idx = printer["gcode_macro _sb_vars"].logo_idx %}
    {% set transmit=params.TRANSMIT|default(1) %}

    _set_sb_leds led={led} red={red} green={green} blue={blue} white={white} idx="{idx}" transmit={transmit}

[gcode_macro _set_nozzle_leds]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    {% set red = params.RED|default(0)|float %}
    {% set green = params.GREEN|default(0)|float %}
    {% set blue = params.BLUE|default(0)|float %}
    {% set white = params.WHITE|default(0)|float %}
    {% set led = printer["gcode_macro _sb_vars"].nozzle_led_name ~ "_t" ~ tool_nr|string %}
    {% set idx = printer["gcode_macro _sb_vars"].nozzle_idx %}
    {% set transmit=params.TRANSMIT|default(1) %}

    _set_sb_leds led={led} red={red} green={green} blue={blue} white={white} idx="{idx}" transmit={transmit}

[gcode_macro set_logo_leds_off]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    {% set transmit=params.TRANSMIT|default(1) %}
    _set_logo_leds red=0 blue=0 green=0 white=0 transmit={transmit} T={tool_nr}

[gcode_macro set_nozzle_leds_on]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    {% set transmit=params.TRANSMIT|default(1) %}
    _set_sb_leds_by_name leds="nozzle" color="on" transmit={transmit} T={tool_nr}

[gcode_macro set_nozzle_leds_off]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    {% set transmit=params.TRANSMIT|default(1) %}
    _set_sb_leds_by_name leds="nozzle" color="off" transmit={transmit} T={tool_nr}

[gcode_macro status_off]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    set_logo_leds_off transmit=0 T={tool_nr}
    set_nozzle_leds_off T={tool_nr}

[gcode_macro status_ready]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="standby" transmit=0 T={tool_nr}
    _set_sb_leds_by_name leds="nozzle" color="standby" transmit=1 T={tool_nr}

[gcode_macro status_busy]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="busy" transmit=0 T={tool_nr}
    set_nozzle_leds_on T={tool_nr}

[gcode_macro status_heating]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="heating" transmit=0 T={tool_nr}
    _set_sb_leds_by_name leds="nozzle" color="heating" transmit=1 T={tool_nr}

[gcode_macro status_leveling]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="leveling" transmit=0 T={tool_nr}
    set_nozzle_leds_on T={tool_nr}

[gcode_macro status_homing]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="homing" transmit=0 T={tool_nr}
    set_nozzle_leds_on T={tool_nr}

[gcode_macro status_cleaning]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="cleaning" transmit=0 T={tool_nr}
    set_nozzle_leds_on T={tool_nr}

[gcode_macro status_meshing]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="meshing" transmit=0 T={tool_nr}
    set_nozzle_leds_on

[gcode_macro status_calibrating_z]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="calibrating_z" transmit=0 T={tool_nr}
    set_nozzle_leds_on T={tool_nr}

[gcode_macro status_printing]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="printing" transmit=0 T={tool_nr}
    set_nozzle_leds_on T={tool_nr}


[gcode_macro status_docking]
gcode:
    {% set tool_nr = params.T|default(printer.tool_probe_endstop.active_tool_number)|int %}
    _set_sb_leds_by_name leds="logo" color="docking" transmit=0 T={tool_nr}
    set_nozzle_leds_on T={tool_nr}    
```

I've also added STATUS_DOCKING, which is called in the dropoff and pickup gcode in toolchanger.cfg:
```
STATUS_DOCKING T={tool.tool_number|string}
   .... the rest of the macro ...
M400
STATUS_READY T={tool.tool_number|string}
```

Now at least the leds are set on the correct toolhead





