# Testing script for Dota2

This is a demo file and scripts to test dota2 performance.

## Installation

You'll need to download the script and the .dem file. If using git clone be aware that you'll need git-lfs to get the dem file.

### Windows

This assumes that you've installed steam in the standard location (C:\Program Files (x86)\Steam), If you haven't you'll need to adjust for that assumption.

Copy the dem file to "C:\Program Files (x86)\Steam\Steamapps\common\dota 2 beta\game\dota\"

run the script rundota.bat

I'm unfamiliar with how to get the same results from windows as from Linux, therefor notepad is called to display the results. To get an apples to applies comparison to Linux use the *second* result for each API (by default dx9 is run twice, then dx11 twice, and finally opengl twice).


### Linux

#### Ubuntu

This assumes that you're using ubuntu 16.10. Ubuntu is quirky compared to other Linux distributions in many ways, so it may be easier or more difficult to get this working on a different distribution.

Copy the .dem files to "~/.steam/steam/steamapps/common/dota 2 beta/game/dota/"

run ./rundota.sh

The Linux shell script will print the second run of each API to the console automatically.

#### Other Linux OSes

Other OSes put the steam directory in "~/.local/share/Steam/steamapps/common/dota 2 beta/game/dota/"
