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
[![FPGA Digital Timer](https://img.youtube.com/vi/oacW3tYSKds/0.jpg)](https://www.youtube.com/watch?v=oacW3tYSKds)
<p align="center">
  <img width="460" height="300" src="https://img.youtube.com/vi/oacW3tYSKds/0.jpg">
</p>

## Finite State Machine Diagrams
![Image of MainFSM](https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/MainFSM.png)
![Image of addtimeFSM](https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/addtimeFSM.png)
![Image of countdownFSM](https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/countdownFSM.png)
![Image of RotatorFSM](https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/RotatorFSM.png)

<p align="center">
  <img width="460" height="300" src="https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/MainFSM.png">
</p>
<p align="center">
  <img width="460" height="300" src="https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/addtimeFSM.png">
</p>
<p align="center">
  <img width="460" height="300" src="https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/countdownFSM.png">
</p>
<p align="center">
  <img width="460" height="300" src="https://github.com/adrianmuino/Digital-Timer/blob/master/DigitalTimer/img/RotatorFSM.png">
</p>
