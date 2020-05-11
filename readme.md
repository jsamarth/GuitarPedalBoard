# Multi-effect Guitar Board

This is an FPGA Project on Guitar Effects. Usually, guitarists use one guitar effect Stompbox per effect. This project is aimed at using the FPGA hardware, which is significantly faster than Microcontrollers, to modulate Guitar signals being fed into the board using Digital Signal Processing. 

![VGA monitor displaying the wave passing through time](vga.jpg?raw=true "VGA Display")
![My entire setup](setup.jpg?raw=true "Entire Setup")

## Devices/Software Used

Here is a list of basic requirements for this project:
* Altera DE2-115 FPGA Development Board
* Intel Quartus Lite Software
* VGA Monitor with a VGA cable and a power supply
* To connect with a guitar: an electric guitar, a guitar cable, a 1/4 inch to 3.5mm audio jack, a speaker or an amplifier, Auxilliary cable

## Getting Started

In this repo, you will find only the files I have coded, or the files that are required to make this project work. I have uploaded the entire project, otherwise, my repo would have been bloated.

To use these files in the project, you can follow these steps:
1. Create a new project on Quartus
2. Copy these files in the top level
3. Set Final_Project.sv as the top level

## Features

I want to make this a sophisticated system that allows you to toggle between different effects on the go. I will be adding more features in the coming time (Read the "Future Improvements section"). 

Here are some of the features in the board as of yet:
* Modify the gain of the sound before entering the effects. Note that this is subject to clipping if the input is alread too big, as only 16 bits are used for audio processing. 
* Overdrive Effect: Switch 17 toggles the OD effect. Switch 16 toggles between two modes: a hard clipping at +/-10,000 and a hard clipping at +/-15,000
* Tremolo Effect: Switch 14 toggles the Tremolo effect
* Display a delayed wave moving through time on the VGA monitor

## Future Improvements

I have always wanted to have one gadget that can emulate the effect of multiple guitar effects, in whichever order possible. 

Here are a few ways I would work on this project in the near future:
* Add more effects, such as delay, chorus etc.
* Add a looper
* Provide a functionality to change the order of the effects

Here is what I can do in the future to take this project to the next step:
* Connect the board to a User Interface on a computer or a phone through Bluetooth
* Have 2-3 actual pedals, 5-6 knobs that can be assigned to differect effects through the aforementioned interface.
* Have all the basic effects a guitarists could need, but provide added functionality on the app to let user add more effects.

