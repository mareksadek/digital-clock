# Team members
Marek Šádek (responsible for GitHub and Alarm)

Matěj Ševčík (responsible for ...)

Denis Bandura (responsible for coding stopwatch and writing readme file)

# Abstract
This project focuses on the design and implementation of a digital watch with stopwatch and alarm functionalities using VHDL (VHSIC Hardware Description Language) and an FPGA (Field-Programmable Gate Array) development board. The primary objective was to create a fully functional digital clock system that can display time, set an alarm, and operate a stopwatch. 

[Photo(s) of your application with labels of individual parts.]

[Link to A3 project poster.]

**[Optional: Link to your short video presentation.]*

# Hardware description of demo application
FUnctionality of this project was tested on a fpga board Nexys-a7-50T. The board itself includes many various ports, buttons, 8 seven segment displays and many more which wasn't really much of our concern since the majority of our code was tested on 7 segment display. Next, we will use 3 butoons on fpga board: BTNC, BTNR and BTND. Each buttons should have a different function depending on is their current level of operation. Current level of operation means that each button can either operate as option for choosing a different mode (clock, alarm and stopwatch), or as a function inside of particular mode. For example, in order for stopwatch to properly work, we need start button for assuring start of the counting, pause button for pausing counting and reset button for reseting the whole operation so the clockwatch can operate again. These functions can be in various form applied to alarm and digital clock as well. 

# Software description
Project can be separated into 3 different parts depending on what mode user desires to use. 3 modes are: digital clock, alarm, and stopwatch. In order for these modes to work, code must be translated so it shows on 7 segment display. For this part, we used slightly modified version of bin2seg code we coded earlier as part of school assignment.

# Component(s) simulations
Write descriptive text and put simulation screenshots of components you created during the project.

# References
<li>Online VHDL Testbench Template Generator (lapinoo.net)</li>
<li>Nexys A7 - Digilent Reference</li>
<li>Constraint file for FPGA board Nexys-A7-50T</li>
<li>bin2seg</li>
