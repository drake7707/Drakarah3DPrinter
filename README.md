# Drakarah3DPrinter
Everything related to my 3D Printer

## Info

The printer started of a Formbot kit and has been upgraded

The build steps for the full kit you can find [here](https://github.com/Zev-se/Formbot-voron-2.4-build-guide)

### Hardware Additions:

 - Clicky clack door
 - Tough handles
 - BZI (thinking that my Z tension wasn't good but it ended up being TMC Autotune putting the Z motors in stealtchop which can't go fast)
 - Front USB keystone
 - Very cheap USB Camera
 - Handles by 1-0-R
 - Wiper nozzle (Bambu style)
 - Stealthchanger
    - Top hat
    - Extra toolheads
    - CAN distribution
    - Shuttle instead of TAP
    - Mini BFI
    - Docks with crossbar
    - N3MI exhaust panel for multiple CAN cables instead of Galvanic mod

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
