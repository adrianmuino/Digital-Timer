# Digital-Timer
Embedded custom single-purpose processor implemented in a Xilinx Spartan 3A FPGA fabric using VHDL that controls a digital timer in which the user can set a time between 1 second to 10 minutes.

## Project Objectives
* Implement a digital timer with three hexadecimal displays
* Allow user to specify the timer duration from 1 second to 10 minutes using push buttons
* Light up all the FPGA onboard LEDs to tell the user that the specified time has elapsed
* Provide reset functionality using a Reset push button

## Components
* [Elbert V2 FPGA Development Board](https://numato.com/product/elbert-v2-spartan-3a-fpga-development-board)
* [USB 2.0 Cable A-Male to Mini-B](https://www.amazon.com/AmazonBasics-USB-2-0-Cable-Male/dp/B00NH11N5A)

## Software
_**Windows 10** is the only supported operating system to implement this design.
You will need to create an account with Xilinx to download the required software to replicate this project. Creating an account with Xilinx is **free**_.
* [Xilinx ISE 14.7 Design Suite](https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_ISE_DS_14.7_1015_1.tar)
* [Elbert V2 Drivers](https://numato.com/wp-content/uploads/2019/06/numatocdcdriver.zip)

## Video Demonstration     
<p align="center">
  <a href="https://www.youtube.com/watch?v=oacW3tYSKds">
         <img class= resize width="960" height="540" alt="FPGA Digital Timer" src="https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/Digital%20Timer%20On%20FPGA.png">
  </a>
</p>

## Finite State Machine Diagrams
<p align="center">
  <img width:"700" height="458" src="https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/MainFSM.png">
</p>
<p align="center">
  <img width="700" height="365" src="https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/addtimeFSM.png">
</p>
<p align="center">
  <img width="700" height="313" src="https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/countdownFSM.png">
</p>
<p align="center">
  <img width="700" height="230" src="https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/RotatorFSM.png">
</p>
