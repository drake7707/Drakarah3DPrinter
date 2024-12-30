# Drakarah3DPrinter
Everything related to my 3D Printer

## Info

The printer started of a Formbot kit and has been upgraded

The build steps for the full kit you can find [here](https://github.com/Zev-se/Formbot-voron-2.4-build-guide)

My build log is on Instagram as reels: [part 1](https://www.instagram.com/stories/highlights/18031423286360519/) and [part 2](https://www.instagram.com/stories/highlights/17904237141050138/)

### Hardware Additions:

 - [Clicky clack door](https://github.com/tanaes/whopping_Voron_mods/tree/main/clickyclacky_door) for better sealing of front door
 - [Tough latches](https://www.printables.com/model/1061047-tough-latches-with-space-for-18mm-dowel-pins) (remixed with 1.8mm dowel pins) for easier panel removal
 - [Beefy Z idlers](https://github.com/clee/VoronBFI) for easier Z belt tensioning
 - [Front USB keystone](https://www.printables.com/model/609433-voron-skirt-keystone-for-usbethernet) to easily plug in an USB stick to print from that when network is not availabe
 - Very cheap USB Camera
 - USB splitter 1 to 4 to give me extra USB connections, one towards the back keystone panel, one towards the front USB keystone, one for the USB camera and one unused at the moment (might be used by a Wifi adapter)
 - Sonoff POW R2 to monitor the power usage of the printer (posts to MQTT)
 - [Handles by 1-0-R](https://mods.vorondesign.com/details/xa84lhUN5aMX4nmfZquaQ) with [spacer](https://www.printables.com/model/1098129-top-hat-spacer-for-voron-handle-by-1-0-r) so I can lift and tilt the printer more easily
 - [Wiper nozzle (Bambu style)](https://www.printables.com/model/1054455-voron-24-nozzle-brush-using-bambu-labs-a1-silicon) which is really important as a non clean nozzle will affect probing and thus Z-offset
 - [Stealthchanger](https://github.com/DraftShift/StealthChanger)
    - Top hat
    - Extra toolheads
    - CAN distribution
    - Shuttle instead of TAP
    - [Mini BFI](https://github.com/DraftShift/StealthChanger/tree/main/UserMods/BT123/MiniBFI%20%2B%20MicroBFI) so the gantry clears the crossbar
    - [Docks](https://github.com/DraftShift/ModularDock) with crossbar
    - [N3MI exhaust panel](https://github.com/DraftShift/CableManagement/tree/main/UserMods/N3MI-DG/Umbilical_Plates) and [CAN box](https://www.printables.com/model/1119606-wago-can-distribution-box-for-n3mi-umbilical-plate) for multiple CAN cables instead of Galvanic mod

My steps to convert to stealthchanger is [here](journey-to-stealthchanger.md)

### Software additions

 - [Klippain Shake&Tune](https://github.com/Frix-x/klippain-shaketune) (for belt comparison and input shaping)
 - [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) with everything set to performance becaues I had issues with silent tuning
 - Exclude object
 - [Klipper Backup](https://klipperbackup.xyz/) (to automatically backup the config to github)
 - [Crowsnest](https://github.com/mainsail-crew/crowsnest) and [Moonraker Timelapse](https://github.com/mainsail-crew/moonraker-timelapse) (for webcam stream and timelapse gneneration)
 - [NanoMQ](https://nanomq.io/) running as a systemd service as a MQTT server, where a Sonoff pow R2 is posting power metrics to, and moonraker ingests those values
 - [udev-media-automount](https://github.com/Ferk/udev-media-automount) as a systemd service to auto mount USB sticks, a symlink is created to the gcodes folder so USB sticks are exposed on the klipperscreen for printing
   

## BOM

I try to keep track of a full bill of materials of the entire printer, so anything I add or remove gets updated in the BOM. You can find that [here](BOM.xslx)
