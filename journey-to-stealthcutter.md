# Journey to StealthCutter

## What

The CoreXY motion system of a 3D printer can be used for other things, such as a Vinyl Cutter or plotter. 

## Why

A dedicated Vinyl cutter machine costs a lot, adding a toolhead is maybe 20€. I wanted to try out a cutting head, StealthChanger makes it really easy to swap toolheads, and see if I could cut vinyl, to use as stickers (no surface left untouched with this new power!)

## Details

### Stuff needed
* CB09 blade holder with blades (https://www.aliexpress.com/item/1005007470135620.html)
* Some M3 hardware to mount the backplate and clamp
* Everything you need to put the backplate onto the shuttle (magnet, 2 FHSC's, 3 dowel pins)
* Cutting mat, there are various ones with different glue strength. StandardGrip worked fine for me (https://www.aliexpress.com/item/1005006356387230.html)
* Vinyl sheets, the non thermal variant (I bought https://www.aliexpress.com/item/1005007381981091.html, backing is a bit shit tho)
* Transfer paper (I bought https://www.aliexpress.com/item/1005007081186498.html)

### Toolhead 
[Someone](https://github.com/Telekatz/Voron-Mods/tree/main/Drag%20Knife%20Toolhead) already made a toolhead for a a drag knife, compatible with a TAP plate. As StealthChanger backplates use the same mounting holes I took that as a basis and modified it to be more secure on a StealthBurner backplate

![PXL_20250428_125943658](https://github.com/user-attachments/assets/707c4af3-83e5-40e4-8cca-3329035c0d9d) (with an incorrectly installed blade, see [this video](https://www.youtube.com/watch?app=desktop&v=6PlIlYayNu8) how to install the blade properly, it should stick out only a mm or 2 from the holder.)

### Cutting mat
![PXL_20250428_131826029](https://github.com/user-attachments/assets/a8850a8f-5946-4f4e-ba86-a4a172334ae6)

The cutting mat comes with a sticky surface for the vinyl sheets to adhere to so it doesn't move, there are variations but StandardGrip seems to work fine with vinyl sheets. Unfortunately there is no easy way to secure the cutting mat onto the bed in a way that it doesn't shift. I've tried using N52 magnets and that holds it down relatively well but I still need to give it some extra clamping force with my fingers while it's cutting. Either stronger magnets or some quick release clamps would maybe help.

The toolhead does not have an Octotap and MCU so it can not be automatically docked and picked up. Homing and QGL on the cutting mat which is 0.4mm thick does not become an issue with docking (as the extra offset would put the docks higher than they really are), so it's technically possible to auto dock T0 and pick up the cutter. However some extra macros will be necessary, like a `CUT_START MODE=cut` to set the printer up for cutting, similar to the `PRINT_START`

### Software

With the hardware in place, it was time to find software. [Polycut](https://github.com/IridiumIO/PolyCut) works well to generate Klipper compatible G-code from SVG files and has some nice features. Right now it emits a G28 homing g-code which really should not be done with a sharp blade, the author modified their klipper configuration to home manually, but I can just home and quad gantry level with T0, then dock T0 and put the cutter on.
Removing the G28 is a mandatory extra step.


### Process

There are a fair bit of steps involved:

1)  Home/QGL/Home with T0
2) Dock T0 manually
3) Put on the cutter toolhead
4) Put the cutter mat on the PEI plate if it's not already. Secure with magnets/clamps so it can't shift around (or hold it by hand when it's cutting)
5) Stick the vinyl sheet lightly onto the cutting mat. If the backing of the vinyl is shit it will tear if you press it on too hard
6) Figure out at what Z the cutting is biting into the vinyl. Too high and it won't cut the vinyl all the way through, too low and it will also cut through the backing which holds the parts of vinyl you want in the correct place. Set that Z into Polycut as cutting height.
7) Generate the Gcode. Overcut might be necessary to not have some corners be not entirely cut. Remove the G28 command from the file. 
8) Upload the file and run it, it should cut immediately (I've asked for a preview / trace bounding box feature)
9) Remove cutting mat
10) Remove vinyl sheet from the cutting mat
11) Cut out the part and pry off the vinyl you don't want caaarefully, if it sticks to the vinyl you do want it's basically fucked.
12) Use transfer paper to transfer the vinyl onto the transfer paper.
13) Peel off the backing of the vinyl and stick it onto the surface you want. Make sure to clean the surface so there's no dust/oily fingerprints. 
14) Squeegy it to make sure it adheres properly and remove transfer paper aaand DONE!

## Result

After some trial and error finding the right Z value (too high and it won't cut all the way through the vinyl, too low and it will also cut through the backing holding the vinyl together, I managed to get a decent cut done

![PXL_20250428_140546953](https://github.com/user-attachments/assets/1f1a17c4-f7d2-4c58-9739-6e6beb0218e5)

![PXL_20250428_144520767](https://github.com/user-attachments/assets/ab983d68-4ff2-43bc-9830-bbaf7bdb5eb4)

