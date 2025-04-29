# Team members
Marek Šádek (responsible for GitHub and Alarm)

Matěj Ševčík (responsible for inicializing digital_clock, top_level, top_level schematic)

Denis Bandura (responsible for stopwatch and readme file)

# Abstract
This project focuses on the design and implementation of a digital watch with stopwatch and alarm functionalities using VHDL (VHSIC Hardware Description Language) and an FPGA (Field-Programmable Gate Array) development board. The primary objective was to create a fully functional digital clock system that can display time, set an alarm, and operate a stopwatch. 

# Schematic
![top_level schematic](https://github.com/mareksadek/digital-clock/blob/main/digital_clock/scheme.png ) 

# Hardware description of demo application
This project creates a digital clock system implemented on the Nexys A7 FPGA board. It features core timekeeping functionality for tracking hours, minutes, and seconds, along with a basic alarm capability. When the alarm condition is met, an LED indicator is triggered to alert the user. The system is currently controlled using a single onboard push button (BTNC), which serves as a reset signal to initialize the clock. Time values are output via a 7-segment display, driven by a binary-to-7-segment conversion module. The display currently shows one digit at a time, with a fixed anode configuration. A 100 MHz clock drives the entire system, and all modules—digital clock, alarm logic, LED control, and display driver—are connected through a top-level VHDL architecture.

# Software description
Project can be separated into 2 different parts depending on what mode user desires to use. 2 modes are: digital clock with alarm and stopwatch. In order for these modes to work, code must be translated so it shows on 7 segment display. For this part, we used slightly modified version of bin2seg code we coded earlier as part of school assignment.

# Component(s) used and simulations
<li>bin2seg.vhd</li> primary focus of this code was to translate binary number to decimal, so the 7-segment on fpga can display decimal numbers. As the 7-segment display consists of 7 segments that can display numbers or letters based on the chosen segments. The conponent was slightly upgraded, but in the end, we used code from school assignment.
<li>digital_clock.vhd</li> This VHDL code implements a basic digital clock that counts hours, minutes, and seconds from 00:00:00 to 23:59:59. It resets the time to zero when the rst signal is high. Time counting is triggered by the rising edge of the clock signal. An LED blinks approximately every five seconds, based on a counter assuming a 100 MHz input clock. There is also a basic alarm mechanism where the alarm_triggered signal is set when alarm_enabled is high. The outputs include current time and the blinking LED.

![Digital_clok](https://github.com/mareksadek/digital-clock/blob/main/digital_clock/dig_clock.png )

<li>stopwatch.vhd</li> This component's behaviour should let user measure time intervals, typically in seconds or minutes. It allows user to start, stop and reset the timing, so the user can track activity or event. 
 
![Simulation of ticking stopwatch in vivado](https://github.com/mareksadek/digital-clock/blob/main/digital_clock/stopwatch_screenshot.PNG )

<li>alarm.vhd</li> Alarm's function is for diode to lighten up in case where specific time event occurs. Using digital clock, some specific time frame is set, and when this time frame is reached, control diode will warm user of evnet's occurance.
We did not provide alarm function with simulation source as there is no point in simulating this component

![Digital_clock](https://github.com/mareksadek/digital-clock/blob/main/digital_clock/diode.jpg )

# References
<li>Online VHDL Testbench Template Generator (lapinoo.net), <a href="https://vhdl.lapinoo.net/">website</a></li>
<li>Nexys A7 - Digilent Reference, <a href="https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual">reference manual</a></li>
<li>Constraint file for FPGA board Nexys-A7-50T, <a href="https://raw.githubusercontent.com/Digilent/digilent-xdc/master/Nexys-A7-50T-Master.xdc">constraint file</a></li>
<li>bin2seg <a href="https://github.com/tomas-fryza/vhdl-labs/blob/master/solutions/lab3-segment/bin2seg.vhd">bin2seg.vhd</a></li> 
