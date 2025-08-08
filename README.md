# Drakarah 3D Printer
Everything related to my 3D Printer

**[Blog](/blog.md)**

![PXL_20250808_152049643_preview](https://github.com/user-attachments/assets/e11af304-4bc9-49c3-a0b0-36fcd5df3c11)



## Info

The printer started of a Formbot kit and has been upgraded.

The printer is capable of printing multiple colors and multiple materials on a 350x350x340 build volume, except for the volume where the docks reside so it's more 350x250x340 and 350x350x100. It also has a cutter toolhead to cut vinyl sheets 

The build steps for the full kit you can find [here](https://github.com/Zev-se/Formbot-voron-2.4-build-guide)

My build log is on Instagram as reels: [part 1](https://www.instagram.com/stories/highlights/18031423286360519/) and [part 2](https://www.instagram.com/stories/highlights/17904237141050138/)

### Hardware Additions:

 - [Clicky clack door](https://github.com/tanaes/whopping_Voron_mods/tree/main/clickyclacky_door) for better sealing of front door
 - [Tough latches](https://www.printables.com/model/1061047-tough-latches-with-space-for-18mm-dowel-pins) (remixed with 1.8mm dowel pins) for easier panel removal
 - [Beefy Z idlers](https://github.com/clee/VoronBFI) for easier Z belt tensioning
 - [Front USB keystone](https://www.printables.com/model/609433-voron-skirt-keystone-for-usbethernet) to easily plug in an USB stick to print from that when network is not availabe
 - Very cheap USB Camera which I dissected to extract the board, access the focus ring and print my own smaller more [adjustable mount](https://github.com/drake7707/Drakarah3DPrinter/blob/main/CAD/CameraMount.step)
 - USB splitter 1 to 4 to give me extra USB connections, one towards the back keystone panel, one towards the front USB keystone, one for the USB camera and one used by a Wifi adapter
 - Sonoff POW R2 to monitor the power usage of the printer (posts to MQTT)
 - [Handles by 1-0-R](https://mods.vorondesign.com/details/xa84lhUN5aMX4nmfZquaQ) with [spacer](https://www.printables.com/model/1098129-top-hat-spacer-for-voron-handle-by-1-0-r) so I can lift and tilt the printer more easily
 - [Wiper nozzle (Bambu style)](https://www.printables.com/model/1054455-voron-24-nozzle-brush-using-bambu-labs-a1-silicon) which is really important as a non clean nozzle will affect probing and thus Z-offset
 - [Stealthchanger](https://github.com/DraftShift/StealthChanger)
    - Top hat
    - Extra toolheads
    - Fysetc Hexa distro fusion board with backpack for CAN distribution
    - Shuttle instead of TAP
    - [Mini BFI](https://github.com/DraftShift/StealthChanger/tree/main/UserMods/BT123/MiniBFI%20%2B%20MicroBFI) so the gantry clears the crossbar
    - [Docks](https://github.com/DraftShift/ModularDock) with crossbar
    - [N3MI exhaust panel](https://github.com/DraftShift/CableManagement/tree/main/UserMods/N3MI-DG/Umbilical_Plates) and [CAN box](https://www.printables.com/model/1119606-wago-can-distribution-box-for-n3mi-umbilical-plate) for multiple CAN cables instead of Galvanic mod
    - [Axiscope](https://github.com/nic335/Axiscope) with hartk sexbolt for easy inter-tool nozzle offset calibration
  - Vinyl cutter toolhead
  - [The Filter](https://www.printables.com/model/334276-the-filter-for-voron-24) with side bed filters (instead of Nevermore) (the screw in remix)
  - [Filament rollers](https://www.printables.com/model/73636-filament-spool-roller-w-608-bearings)
  - [FilamAtrix toolheads](https://github.com/thunderkeys/FilamATrix) (ECAS inlet, filament runout sensors and filament cutter integration)
  
    
My steps to convert to StealthChanger are [here](journey-to-stealthchanger.md)

My steps to add a cutter toolhead are [here](journey-to-stealthcutter.md)

### Software additions
 - Using the latest Armbian image instead of the BTT CB1 image as OS because it gets updates and has the latest kernel (was necessary for wifi adapter drivers) and CPU frequency governor support
 - [Klippain Shake&Tune](https://github.com/Frix-x/klippain-shaketune) (for belt comparison and input shaping)
 - [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) with everything set to performance because I had issues with 'silent' tuning
 - Exclude object
 - [Klipper Backup](https://klipperbackup.xyz/) (to automatically backup the config to github)
 - [Crowsnest](https://github.com/mainsail-crew/crowsnest) and [Moonraker Timelapse](https://github.com/mainsail-crew/moonraker-timelapse) (for webcam stream and timelapse gneneration)
 - [NanoMQ](https://nanomq.io/) running as a systemd service as a MQTT server, where a Sonoff pow R2 is posting power metrics to, and moonraker ingests those values
 - [udev-media-automount](https://github.com/Ferk/udev-media-automount) as a systemd service to auto mount USB sticks, a symlink is created to the gcodes folder so USB sticks are exposed on the klipperscreen for printing
 - @reboot script to always create a fixed symlink for the usb webcam, it sometimes was /dev/video0, sometimes /dev/video1 so with a udev rule it is now always /dev/webcam
 - Mainsail [fork](https://github.com/fakcior/mainsail/releases) by fakcior for toolchanging and [toolmapping](https://github.com/fakcior/klipper-toolchanger-tool-mapping)
 
## BOM

I try to keep track of a full bill of materials of the entire printer, so anything I add or remove gets updated in the BOM. You can find that [here](BOM.ods)
<details>
  <summary>BOM overview</summary>
  ![image](https://github.com/user-attachments/assets/876b5364-e255-4b9d-9ea6-b020f880854d)
</details>

## Lessons learned and things I would change if I did a new build

There are some things that I would do different now that I have built one and ran into several issues over the months

 - Print parts out of ABS instead of eSun ABS+. eSun ABS+ used to be recommended but since they changed their formula layer adhesion and heat resistance is bad.
 - Use an Octopus Pro board with a RPI4 instead of a M8P with CB1 that the Formbot came with. Unfortunately there is no option to choose that when ordering a new kit so I'd be stuck with it anyway, but the CB1 really is not powerful enough. A lot of TTCs and timing issues come down to host delays. It can be mitigated somewhat by using the latest kernel with armbian, setting up a performance CPU governor, adding nice to klipperscreen and other non essential processes and so on but all of this would be avoided if I could just use a RPI4. Being stuck with having to use a compute module for the M8P is really limiting the options for upgradability.
 - Get a bigger 24v power supply, the default 200W that came with the kit is good for a single toolhead, but not so if you run multiple toolheads in a toolchanger. I got away with it with using 3 toolheads of varying sized heaters, 70,60 and 40W but there really is no more room to add another one.
 - Use screw in magnets instead of glueing them in with CA glue. They keep popping out. 2 component epoxy also works and it makes it easier to position the magnet properly as it has a longer setting time but ideally I want something that is more robust.
 - Use 3mm wide spring steel instead of 2 1mm piano wires so the umbilicals don't flex to the side as much. I've changed all the umbilicals and it works so much better.
 - Buy decent fans for the toolheads. The cheap ones are either obnoxiously loud or don't cool the hotend that well. Ideally I want fans with rpm monitoring to stop heating when the fan fails.
 - The EBB36 toolhead board is half the price as a SB2209 and works just as well. The terminal block kind of sucks compared to the molex connector for the heater and there is no easy 5V/12V fan option but the price makes up for it. It's also not limited to just the StealthBurner toolhead.
 - Speaking of toolheads, the stealthburner looks good but there are more lightweight and more compact toolheads available. Anthead is popular for StealthChanger builds.
 - Don't buy a Dragon HF hotend. It's really not worth the extra price when you can buy 4 Bambu like TZ2.0 V6 style hotends for the same price. Even the super cheap V6 clones work well.
 - Buy 10m PTFE tube instead of the cheaper 1m, it's so much nicer to just have enough PTFE tube that bends are relaxed. So many issues I had with underextrusion and PLA filament snapping under stress was due to tight bends or pinched points in the bowden tube.
 - Don't put your printer on a spot that has a lot of sunlight. Yes the free heating is nice, but ABS parts really don't like UV and mine significantly bleached after only a couple of months.
 - Anything that is loose will rattle loudly during printing and annoy you. The Filter lids are slide in lids and not tight enough to not rattle, some superglue fixed that. The Clicky clack door panel also needed some extra panel or it would rattle in its extrusions. Test for rattle during assembly.
 - Pull on your dang crimps after crimping. If they come off it was a bad crimp and can cause intermittent connection issues. I've made some bad crimps and the thermistor dipped and caused prints to fail. Having to disassemble to recrimp is no fun, test during assembly.
   
