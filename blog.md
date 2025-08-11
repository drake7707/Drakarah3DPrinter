
# 2025-08-05 Finishing up & toolless homing

I've finished building the remaining toolhead and routing all the umbilicals and bowden tubes properly. Even put some numbers on the toolheads and filament inlets to keep track of which one is which

![PXL_20250804_173238952_preview](https://github.com/user-attachments/assets/d98841a0-c23f-43d7-b2c6-b5186ec76e5b)

The bowden tubes are slightly less than 2m long, which I hope isn't going to introduce too much friction but it does look a lot nicer and has a lot less bends in it.

![PXL_20250727_120601292_preview](https://github.com/user-attachments/assets/71bdb8c4-f720-4fe0-aa6d-d20441f0a7d7)

![PXL_20250731_151751206](https://github.com/user-attachments/assets/1e5db9b8-527f-4d7c-8e11-d8db4c1e5c02)

I've also spent some time getting toolless homing to work. It looks a lot nicer when all the tools are parked in their docks but the toolchanger software didn't allow for shuttle only homing

[![Watch the video](https://img.youtube.com/G2TRkZCBAtQ/default.jpg)](https://youtube.com/shorts/G2TRkZCBAtQ)

I had to do a couple of things: 

1. Make a Z-endstop that the shuttle could reach but doesn't interfere when tools are on the shuttle ![PXL_20250803_063140733_preview](https://github.com/user-attachments/assets/7a0ac8c0-486b-443a-8cf0-53760b14aa77)

2. Define a [tool_probe] with a negative tool number for the endstop
   
2. Make a small patch in klipper-toolchanger to allow multiple probes not triggered if one of the probes is from a negative probe (because the endstop will always be not triggered)

3. Adjust the homing sequence to check if there is a tool or not and home X,Y then move to the endstop and home Z for shuttle only.

It works fairly well and I can pick up tools without an issue.


# 2025-07-26 Summer upgrades

With the Aliexpress summer sales I bought enough stuff to build a 4th and 5th toolhead. This time around I wanted to build the 4th toolhead as a [FilamAtrix](https://github.com/thunderkeys/FilamATrix) toolhead with cutter and runout sensor built in. 

![PXL_20250717_131254119_preview](https://github.com/user-attachments/assets/95d5cc46-32b0-472a-8732-1e49d7f059ad)

This ended up not being so straightforward. The v6 mount is not supported by FilamAtrix, so I used the one from Filametrix, but that also meant I had to cut the blade differently (I could not cut the hardened steel blade, instead I bent until it shattered in roughly the correct spot) so it rests on the lip of the heat sink and I had to add a sleeve with PTFE tube and a chamfer cut with an exacto knife. That seemed to work alright. I also had to chafe off part of the extruder housing because the clone V6's stick out 1 mm and it clamped the knife down when assembled so cutting away some plastic gave it some room to cut without any friction.

![PXL_20250726_083201591_preview](https://github.com/user-attachments/assets/52dbe668-0c39-41e1-959d-567415733a3d)

The filament runout sensors also were not easy to install. The ball bearings are exactly 5.5mm so that wasn't the problem, but the holes in the switches did not line up with the holes to mount them. If I did force screws through they would be too close and be always triggered. I ended up fiddling with it, adding some tape to the front, drilling out a hole on the other so I could get it to the position where it reliably triggered/not triggered when I added/removed filament.

I found the best way was to add some layers of tape on the switch and then screw in the self tapping screws with an angle, that seemed to work very consistently across multiple toolheads.

Another issue I had was I had to add spacers for the Octotap as the extruder motor is a lot taller than the ones I bought previously

![PXL_20250719_090806072_preview](https://github.com/user-attachments/assets/4b6abf2f-01b9-4f5d-8e7e-17270e2d77ea)

It still triggers correctly so not a big deal.

I forgot how long it took to trim wires to length and crimp connectors, but in the end I have a new toolhead.

![PXL_20250719_121814919_preview](https://github.com/user-attachments/assets/18731045-3c4c-490e-88e8-fc1ba1f69f3b)

One of the other things I wanted to tackle at the same time was redoing my umbilicals with spring steel. I used piano wire before and they were very sloppy. So I printed the umbilicals v2 exhaust plate from N3mi, detached everything, removed all the cables, and rebuilt the umbilicals, this time with proper PG7 glands on T0 and T1 too so they screwed in snugly, the ones I had from Formbot had a different pitch or out of spec tolerances and it just didn't sit well in the exhaust plate, that also caused a lot of sloppiness.

![PXL_20250723_124743320_preview](https://github.com/user-attachments/assets/32cb7ba5-9029-4dca-a172-74ccbf3ff3e7)

Pretty happy with that, they look a lot better and hold their form a lot better.

I also managed to snag a Fsyetc Hexa Distro Fusion board for an early bird deal, it's a distribution board for both CAN and USB toolheads but also has a dedicated chip with lots of GPIO. That means I can add a lot more sensors directly to that board instead of having to route everything to the electronics bay.

![PXL_20250724_132922123_preview](https://github.com/user-attachments/assets/77a8bb25-8924-4a26-93d5-8a72f39c682e)

It's a very new board and there isn't a proper mount for it yet, so I took the time to redesign a new backpack to hold it in place.

![PXL_20250726_152013076_preview](https://github.com/user-attachments/assets/d21e8d54-7f8a-4319-85d7-d37324cc2b25)

One of the other issues I had was filament breaking in the bowden tubes at certain points because the filament was under stress, especially the cheap PLA is very prone to that, so I really want to reroute the bowden tubes to have as little sharp bends as possible, I bought 10m so I can cut them to length and use 2m instead of 1m to make a gentle path towards the spools.


It's still a work in progress in the end the printer will be a lot better, it's the small things.

# 2025-07-10 Sun exposure

I put my printer in my office room on a spot that received a lot of sunlight. I thought the free heating for the chamber would be nice, but now that it's summer the UV is a lot higher and my ABS parts are suffering, I didn't realize how much they have become bleached until I printed a new part and held it next to an older part.

![PXL_20250710_134234707_preview](https://github.com/user-attachments/assets/4c7098cd-9361-4a48-b302-e3b8dbf642ed)

Yikes. Needless to say I moved some things around.

# 2025-06-29 Axiscope

After the last recalibration I ordered the parts to try out Axiscope, basically aligning the tool nozzles visually with a camera. It was pretty cheap anyway, cheaper than a sexball probe and it works great. I had to solder 4 leds (I ordered leds that were too large so I had to drill the holes bigger) to the board, snapped it shut, glued in 2 magnets (4 really seemed overkill with N52) and it works well. The webpage to control the toolhead and measure the offset is pretty easy to use and I could do an entire calibration in a few minutes or less, much faster than the shenanigans I had with the sexball probe and probe that used a StealthChanger pin and bushing, no more going out of bounds, no more samples exceed tolerance, just align and bam done. My calibration was pretty spot on, they were already pretty well aligned, which meant that the values I got from the probe were not very accurate because that suggested over a mm change.

Pretty happy with it, now I just need to change the sexball probe into a normal Z-endstop and set up Axiscope to use the probe for calibrating the Z-offsets.

![PXL_20250629_163239899_preview](https://github.com/user-attachments/assets/56f14020-5662-4564-9183-f77696356acf)

If you're unsure which tool calibration method to use, I heartily recommend this one.

Another thing I learned recently thanks to https://youtu.be/mkgGAVH_XZM is why my sexball probe and pin probe were so inaccurate no matter what I tried. I thought it was the tolerance of the pin and bushing but I never considered the concentricity of the nozzle orifice. I run very cheap nozzles so I doubt they are symmetrical and concentric at all, giving me a bias towards one side. Another reason why camera based alignment is so much better and easier, it takes out the guessing game of whether tolerances are good enough and doesn't rely on the quality of parts.


# 2025-06-10 Recalibration & print

I managed to recalibrate the nozzles, my sexball probe is useless, it was way off, there's just too much play in the sexball probe shaft and bushing so I need to find a better way for calibration, I might try [Axiscope](https://github.com/nic335/Axiscope), which would be great for X,Y alignment and rather cheap. Z I can do easily with a test print. Anyway, after multiple test prints I got it dialed in properly.

So I did a stress test print and the second attempt worked fine (I had some issues with my config of Tool mapping that nuked the first attempt):
![PXL_20250609_154216659](https://github.com/user-attachments/assets/9ae4fd86-a5c9-4db7-ae2d-1f2310546ada)
![PXL_20250609_154244922](https://github.com/user-attachments/assets/9b6c753b-308c-4e24-adf8-b25571ec3ee4)

It came out nicely, I scaled up Calidragon by 200% so it was 352 tool changes and it worked flawlessly. It took 4h23min, mostly because my tool changes weren't super optimized to be fast.

So I did that next, increased the Z speed to 200mm/s from 150mm/s, increased Z acceleration to 750mm/s² from 350mm/s². Optimized the pickup and dropoff gcode to use faster XY speeds (300mm/s), removed the M400 from the dropoff gcode that introduced a delay and removed the verify code on pickup as it gets verified after the pickup code runs anyway, it was there to bail out early before potentially dragging the tool off the dock. Bit of a risk but my tools have survived the dive to the bed before.

And i've gotten it down to about 8 seconds for a tool change, it used to be around 15 seconds:

[![Watch the video](https://img.youtube.com/vi/LBZMbHjzhpM/default.jpg)](https://youtu.be/LBZMbHjzhpM)

It's really nice to see such a big improvement over my past multi color prints.

# 2025-06-08 Software updates and shenanigans

I was still on the klipper-toolchanger commit from July 2024 and some improvements had been done recently to not have those false positive crash detection triggers anymore, I couldn't also update Klipper because the old version wouldn't be compatible so I took the plunge and updated everything.

Unfortunately a lot had changed since in the gcode as well and nothing was documented, so I had to compare my gcode for picking up and dropping off tools with the newer version. Eventually I got it working, mostly.

One issue I encountered was that the now split dropoff and pickup path was not correct for my Stealthchanger and Stealthburner tool heads, so I used the old path. That worked but not before ramming T0 at full speed into the bottom of the docks.

This has unfortunately some consequences, or maybe it had to do with the update, I don't know, but T0 and T1 would not dock properly anymore. I had to recalibrate the dock and park position of the tools so it drops it nicely without moving and can pick it up without any jerkiness to the pins. This is really important because it would lead to sporadic docking/undocking issues.

After that I noticed when starting a print that the crash protection now works differently and I had to put it a verify tool check in the after later gcode. I don't like this, this causes a delay on every layer change, so I will probably remove that check. Most if not all crashes happen during tool changing anyway.

When I finally gotten a multi tool test  print done again I noticed my calibration was way waaay off, especially on T1. I did remove the nozzle and hotend at some point after a jam and didn't recalibrate.

So I recalibrated, and then the magnet in the shuttle decided to come loose, as well with several pins from T0 due to the added friction of not having a magnet snap the tool in place. Sigh, this would have been a good time to use the two component epoxy I borrowed but apparently lost when I forgot to close the zipper of my bag. I ordered some from Amazon to replace that, but that meant I had to use super glue *again*, which means it will fail again in the near future.

Getting the stupid magnet to sit flush in the shuttle is a pain when there's superflue underneath it. I seemed to have raised it a wee bit because T0 now had inconsistent probe trigger issues. It really never stops does it? Anyway, it was only T0, the others were fine, I loosened the Octotap, pushed it down as far as I could and tightened it again and that did the trick. I already did that on the other tools so I knew it was a good thing to try.

So now I just have to calibrate the z-offset and gcode offset of every tool again, the new magnet location will have shifted things somewhat and then it should be good to go.

I really want to do another multicolor print in a hopefully more reliable fashion but this ended up being a whole lot more work than I planned for.


# 2025-05-15 Some small updates

I've done some small software updates, mainly for some quality of life:

1. I've switched mainsail to the [fork](https://github.com/fakcior/mainsail) with toolchanger support by fakcior. This gives me a nice UI box per tool to activate,load and unload the filament. I could already do that on KlipperScreen but it's still kind of a hassle. Tool remapping is another big one, there is currently no way in OrcaSlicer to swap colors in a painted m3f model, which means I would need to swap the filaments to the tools according to the painted scheme. That's kind of dumb, luckily [this](https://github.com/fakcior/klipper-toolchanger-tool-mapping) allows for remapping the gcode before starting the print. It's still an extra step but at least it's possible now
![431562327-bf8e2c3a-cb0d-4ef9-af06-b4f71f41f3fb](https://github.com/user-attachments/assets/206acbce-617c-41b2-b5d0-b77da5afed3c) (*screenshot from the repo*)

2. I've changed some macro's here and there, nothing major, things like not disabling the motors on print end and moving to the nozzle brush before heating up to target temp so the ooze doesn't get dragged all over the bed.

3. The filament rollers work pretty well, but sometimes it does snag hard enough on the roll that it yanks it off the roller sideways, I have added some filament guides to hopefully mitigate that

# 2025-05-06 Vinyl stickers are cool

![PXL_20250506_115114144](https://github.com/user-attachments/assets/9b94b8a0-b46a-4e85-ba3e-b1c872203233)

I used the cutter to make some decals for the top hat, the small lettering was a pain in the ass to transfer but I got it in the end, kinda.


# 2025-05-06 Filament spools driving me crazy

The stealthchanger backpack I made really did not have great routing of the PTFE tubes, my printer is in the corner of my room and accessing the filament spools on the far side was a nightmare, I actually bent the PTFE tube multiple times, there was also no strain relief. The shitty Sunlu PLA+ filament breaks if there is so much as a tiny bit of resistance if it's not dried which also prompted this change.

I got so pissed off I changed the whole thing, initially I designed a spacer to hold the PFTE connectors but that didn't work because the bent upwards would be too great, so option B, drill holes in the backplate of the backpack and use raw force to thread the connectors in. It's not pretty and I really should reprint the back plate with proper m10 threaded holes, but it will do for now.

![PXL_20250506_103047355](https://github.com/user-attachments/assets/23be577d-4dca-433a-be84-dda4813287f0)

It makes removing the back plate harder and putting it back in place against the barbs of the connectors even more so (luckily I can push the black rings around it down to keep the barbs from biting into the PFTE tube, one at a time)

![PXL_20250506_103354888](https://github.com/user-attachments/assets/4983a8d9-53db-4c21-960a-5f5d4226074a)

Next, filament rollers:

I used [this](https://www.printables.com/model/73636-filament-spool-roller-w-608-bearings) model, bought some 608 bearings, realized I needed 20 not 10, so I printed [some 608 bearings](https://www.printables.com/model/561588-bearings-print-in-place-with-real-rolling-elements), they have more resistance but they work.

I extended the rail to the full size of the top, and then cut it in the slicer with a dovetail cut, that didn't work on such a tiny surface, should have just made a slot on one end and screwed it down, but some electrical tape holds it together.

I designed a [clamp](https://www.printables.com/model/1287401-filament-spool-holder-rail-clamp) to bolt the rail to the side extrusions, similar to the top panel clamps, which makes it sit snugly against the top panel. Together with the weight of all the rollers there is almost no play in the rail.

![PXL_20250506_103354888](https://github.com/user-attachments/assets/2efd4e95-05d0-4286-922e-33df240e1e36)

# 2025-05-04 Cleaning up the rat's nest of wires

One thing that was on my TODO list and I was very reluctant to do was to move the Sonoff Pow R2 from an external extension cord to internal. I was reluctant to because I don't like messing with AC wires, but I finally did it anyway. I quadruple checked all the crimps, using the different crimp clamps on my crimper to make sure the wires are in securely (some weren't so good thing I checked!), then cut some wiring and went to work. Finally I stuck the Sonoff on the bottom plate with some double sided tape.

![PXL_20250504_123323908](https://github.com/user-attachments/assets/7c71922b-db0e-4a27-80df-27e1bdac0c50)

Everything still works, nothing blew up and it's a lot cleaner behind my printer now.

# 2025-04-28 Cutting edge technology

I finally got a cutter, details are [here](/journey-to-stealthcutter.md)
