# Team members
Marek Šádek (responsible for GitHub and Alarm)

Matěj Ševčík (responsible for inicializing digital_clock, top_level, top_level schematic)

Denis Bandura (responsible for stopwatch and readme file)

# Abstract
This project focuses on the design and implementation of a digital watch with stopwatch and alarm functionalities using VHDL (VHSIC Hardware Description Language) and an FPGA (Field-Programmable Gate Array) development board. The primary objective was to create a fully functional digital clock system that can display time, set an alarm, and operate a stopwatch. 

[Photo(s) of your application with labels of individual parts.]

[Link to A3 project poster.]

**[Optional: Link to your short video presentation.]*

# Hardware description of demo application
Functionality of this project was tested on a fpga board Nexys-a7-50T. The board itself includes many various ports, buttons, 8 seven segment displays and many more which wasn't really much of our concern since the majority of our code was tested on 7 segment display. Next, we will use 3 butoons on fpga board: BTNC, BTNR and BTND. Each buttons should have a different function depending on is their current level of operation. Current level of operation means that each button can either operate as option for choosing a different mode (clock, alarm and stopwatch), or as a function inside of particular mode. For example, in order for stopwatch to properly work, we need start button for assuring start of the counting, pause button for pausing counting and reset button for reseting the whole operation so the clockwatch can operate again. These functions can be in various form applied to alarm and digital clock as well. 

# Software description
Project can be separated into 3 different parts depending on what mode user desires to use. 3 modes are: digital clock, alarm, and stopwatch. In order for these modes to work, code must be translated so it shows on 7 segment display. For this part, we used slightly modified version of bin2seg code we coded earlier as part of school assignment.

# Schematic

# Component(s) used and simulations
<li>bin2seg.vhd</li> primary focus of this code was to translate binary number to decimal, so the 7-segment on fpga can display decimal numbers. As the 7-segment display consists of 7 segments that can display numbers or letters based on the chosen segments. The conponent was slightly upgraded, but in the end, we used code from school assignment.
<li>digital_clock.vhd</li> 
<li>stopwatch.vhd</li> this component's behaviour should let user measure time intervals, typically in seconds or minutes. It allows user to start, stop and reset the timing, so the user can track activity or event. 
 
![Simulation of ticking stopwatch in vivado](https://github.com/mareksadek/digital-clock/blob/main/digital_clock/stopwatch_screenshot.PNG )

<li>alarm.vhd</li> alarm's function is for diode to lighten up in case where specific time event occurs. Using digital clock, some specific time frame is set, and when this time frame is reached, control diode will warm user of evnet's occurance.


# References
<li>Online VHDL Testbench Template Generator (lapinoo.net), <a href="https://vhdl.lapinoo.net/">website</a></li>
<li>Nexys A7 - Digilent Reference, <a href="https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual">reference manual</a></li>
<li>Constraint file for FPGA board Nexys-A7-50T, <a href="https://raw.githubusercontent.com/Digilent/digilent-xdc/master/Nexys-A7-50T-Master.xdc">constraint file</a></li>
<li>bin2seg <a href="https://github.com/tomas-fryza/vhdl-labs/blob/master/solutions/lab3-segment/bin2seg.vhd">bin2seg.vhd</a></li> 
