# Guide to stealtchanger

## What

[Stealtchanger](https://github.com/DraftShift/StealthChanger) is a toolchanger so multiple tools can be used in the printer. This is significantly faster than multimaterial that uses retract and spool rewinds to feed in new filament.

It requires a fairly large amount of modification.

## Why

It looks cool and it gives me a spare toolhead. I already had a V6 nozzle that I didn't use that came with the kit because I bought the Dragon HF hotend.

## Step by step

### 1. Toolhead

Building a new toolhead is pretty much the same as building the first toolhead. This time I had to crimp the wires myself instead of using the provided wire loom but it was pretty straight forward. I stuck with what I already knew and bought a SB2209 (RP2040) CAN board with the same MOONS NEMA 14 extruder).
![PXL_20241115_141351774](https://github.com/user-attachments/assets/e375053b-a825-4cb5-a7bc-caaf02314941).

I did buy some shitty fans mostly because I wanted to keep costs down and I didn't know if it would work. I might upgrade to better fans later.

### 2. Docks

I printed and assembled the modular docks from DraftShift Design (the same team behind StealtChanger). Assembling them is pretty straight forward, building the cup filled with RTV silicone was the most annoying and messy part. The wiper to hold the small PTFE tube kept breaking too, but with some superglue and some old laptop screws I managed to get it built.

![PXL_20241118_172505338](https://github.com/user-attachments/assets/9c1f6740-cc41-4b75-96a4-aaee30d31547)

![PXL_20241123_173106999](https://github.com/user-attachments/assets/3ddb172d-2559-4109-809d-b28537ac975a)

When mounting them from the top frame it was pretty evident that it wasn't very stable. They vibrated and flexed around a lot, even with torsion so they weren't fully straight. Trying to fix that with the bolts did not work well, so I ended up building a crossbar.

There are a couple of options to provide bottom support, a crossbar with a doorbuffer is the easiest, it spaces out the support in front of the frame providing clearance for the gantry idlers. I instead already bought some 2020 extrusions for the top hat to size, so I used a crossbar between the vertical frames. That also meant ripping out the default front idlers and replacing them with Mini BFI that don't portrude past the frame extrusions

![PXL_20241212_095923227](https://github.com/user-attachments/assets/2fda7d7a-4040-4269-aaa0-8f529973d6d1)

### 3. Sensorless homing

When installing the shuttle there is no X-endstop like there is on the TAP carriage (because otherwise tools wouldn't be able to be detached), so setting up sensorless for X is mandatory. I followed [this](https://github.com/EricZimmerman/VoronTools/blob/main/Sensorless.md) guide and it worked fairly well. The gotcha that got me was that I had to configure TMC autotune as well, otherwise it would work while calibration but fail during normal operation. And it is quite scary home incorrectly and then have the toolhead slam into the gantry. Make sure you calibrate when the gantry isn't level, it adds extra friction so your threshold isn't triggered too soon.

### 4. Shuttle

The TAP carriage needs to be replaced with the StealthChanger shuttle. In fact if you put a backplate on a tool and the shuttle on the X rail then everything will still work with the TAP configuration.

I struggled here to print the shuttle properly, so I ended up using the shuttle keeper spacer to hold the belts in place and then bolt the shuttle to the keeper and the carriage.

Finding N52 magnets seemed to be hard, I found some on amazon but they were 6.7mm instead of 6mm, which meant I had to make changes to the holes where they are inserted. At this point I've gone through several destroyed shuttles and backplates so this got delayed a lot. I ended up buying N52 magnets from Lecktor that were 6mm.

![PXL_20241210_082217101](https://github.com/user-attachments/assets/c10d2ce2-286b-47f1-b71f-bdbe27f3d016)

![PXL_20241210_083455271](https://github.com/user-attachments/assets/d89469c1-2214-4e94-a1ce-d763c15568d2)

![PXL_20241210_090507179](https://github.com/user-attachments/assets/e0968ae7-f725-4829-84c7-c3e573e58fe1)

With the help of the belt keeper I tensioned the belts so I didn't even have to use the idlers tension screws

### 5. Top hat

Umbilicals are probably the most important in a Stealtchanger build. They need to push the tools into the docks so they sit straight (and they can be picked up well) and don't get yanked off by the weight of the umbilical. In order to have enough clearance for the umbilicals the Z needs to be extended. with the top panel on it's impossible to reach the full Z without squishing the umbilical so the solution is a top hat.

There are several options, from a printed top hat to using extrusions and polycarbonate panels. For a 350 build it's recommended to have at least 20mm extra in height, which would be a lot of plastic and I switched to a Clicky Clack door so I had the 2 spare 24cm stock doors lying around, so I decided to go with the latter option.

I miscalculated the vertical extrusion length (I ordered 25cm, and received 24cm for some reason), so my vertical height was off to mount the panels in the same way with tough latches as on the frame panels. I created [a spacer](CAD/TopHatSpacer_v2.step) that not only holds the extrusions together but provides extra height so the 24cm panels can sit flush with the bottom 

My extrusions inner diameter are 5mm, while the ones from the top hat are 6mm. This is annoying as I was planning to use some M5 dowel pins. I ended up designing and printing them instead, [dowelpin](CAD/dowelpin.step), but the top hat extrusions chafe away at them so they are only good for a limited amount of top hat removals before they break.

Another issue I had was that the handles I was using interfere with the top hat panels, I designed and created a [spacer](Voron-1-R-Handle-Spacer.step) for that too. I designed it in such a way that it could be printed standing on its side to provide the best tensile strength.

This is still a work in process and I still don't have the remaining 2 panels so this might change in the future: TODO

![PXL_20241207_132427544](https://github.com/user-attachments/assets/70af1413-4823-4a93-86b8-c429d841b3a1)

### 6. Umbilicals and CAN wiring

For the actual umbilicals I bought some 1mm spring steel piano wire and used 2 of them next to the CAN cable to provide enough rigidity. A 3mm spring steel strip is recommended nowadays but I didn't have that so I tried to mimic it as best as I could. I used some tape to hold them in place and used some sleeving over it. The first umbilical I didn't put the piano wire all the way to the toolhead and I feel that was a mistake, it bend and pushed the toolhead backwards on the dock. When I extended the piano wire all the way to the toolhead (I use PUG instead of PG7) that worked much better for staying in the docks.

Then I clipped the PTFE tube alongside the umbilicals with some custom designed [cable clips](CableClip-Body001.step) (sized to my cable thickness)

![PXL_20241212_154016937](https://github.com/user-attachments/assets/efabc138-f892-4401-b494-5589af3198ec).

Finally the CAN wiring. Initially I had the CAN cable broken out in the electronics bay and used some wago clips, but that meant I also had to run each umbilical downwards, that's not very scalable with more toolheads, so I moved the wagos up near the exhaust and ran 2 1.5mm² power wires along with some leftover CAN cable for the CAN wires and then attached the umbilicals there.

I still need to print a nice box for it but it works, another TODO

![PXL_20241212_154946994](https://github.com/user-attachments/assets/542f5100-15c5-498b-a54a-64917d1460cf)

### 7. Configuration

So far configuration is pretty straight forward, I already defined toolheads in seperate config files, so following the [guide](https://github.com/DraftShift/StealthChanger/wiki/Configuration) was relatively easy.

One gotcha I had during [dock position calibration](https://github.com/DraftShift/StealthChanger/wiki/Calibration) was that (as of the time of writing) it's still recommended to home, QGL and home again with T0, and then find the positions of the docks (this is not mentioned in the guide). The moment I took T0 off the shuttle the crash protection triggered disabling the motors so it was impossible to try and pick up a tool manually to find its dock position. Running `STOP_TOOL_PROBE_CRASH_DETECTION` is necessary to prevent this. Also when picking up the other tool manually, before testing the docking path make sure you re-run `INITIALIZE_TOOLCHANGER` because otherwise it will think T0 is still active and will try to dock on T0 instead of the correct dock.

