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
