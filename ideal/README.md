## TB6612FNG Hookup Guide

The TB6612FNG is an easy and affordable way to control motors. The TB6612FNG is capable of driving two motors at up to 1.2A of constant current. Inside the IC, you'll find two standard H-bridges on a chip allowing you to not only control the direction and speed of your motors but also stop and brake. This guide will cover in detail how to use the TB6612FNG breakout board. The library for this guide will also work on the RedBot Mainboard as well since it uses the same motor driver chip.

### Selecting the Right Motor Driver

Before we get started, let's talk about how to find a motor driver for your needs.

The first step is to figure out what type of motors you are using and to research their specifications. Picking a motor driver for a motor that is not powerful enough isn't helpful. Also, keep in mind there are different motor types (stepper, DC, brushless), so make sure you are looking for the correct type of motor driver. You will need to spec your motor driver and make sure its current and voltage range are compatible with your motor(s). First, you need to make sure your motor driver can handle the rated voltage of your motors. While you can usually run motors a bit above their ratings, it tends to reduce the lifespan of the motor.

Current draw is the second factor. Your motor driver needs to be capable of driving as much current as your motors will pull. As a general rule, go straight to the stalled current number for a motor (the current draw present when you are holding the motor still). A motor will pull the maximum current when it is stalled. Even if you don't plan on stalling your motor in your project, this is a safe number to use. If your motor driver can't handle that much current, then it is time to find a new motor driver (or motor). You may also notice motor drivers often have max continuous current and max peak current listed. These specs are worth noting depending on your application and how much stress your motor will endure.

This guide covers the TB6612FNG motor driver which has a supply range of 2.5V to 13.5V and is capable of 1.2A continuous current and 3.2A peak current (per channel), so it works pretty well with most of our DC motors. If the TB6612FNG does not fit your project's specifications, check out our various other motor driver boards.

As with any board, there are other things to consider such as the logic voltage, which is basically the voltage it uses to talk to your microcontroller, and heat dissipation. While these things definitely need to be considered, they are relatively easy to fix with things like level shifters and heat sinks. However, if your motor is trying to pull more current than your driver can handle, there isn't much you can do to fix it.

### Board Overview

Let's discuss the pinout for the TB6612FNG breakout. We basically have three types of pins: power, input, and output, and they are all labeled on the back of the board.

![board](/ideal/images/layout.jpg)

Each pin and its function is covered in the table below.

|  Pin Label | Function  |  Power/Input/Output | Notes |
|------------|-----------|---------------------|-------|
|  VM        |  Motor Voltage |  Power |  This is where you provide power for the motors (2.2V to 13.5V) | 


		
VCC	Logic Voltage	Power	This is the voltage to power the chip and talk to the microcontroller (2.7V to 5.5V)
GND	Ground	Power	Common Ground for both motor voltage and logic voltage (all GND pins are connected)
STBY	Standby	Input	Allows the H-bridges to work when high (has a pulldown resistor so it must actively pulled high)
AIN1/BIN1	Input 1 for channels A/B	Input	One of the two inputs that determines the direction.
AIN2/BIN2	Input 2 for channels A/B	Input	One of the two inputs that determines the direction.
PWMA/PWMB	PWM input for channels A/B	Input	PWM input that controls the speed
A01/B01	Output 1 for channels A/B	Output	One of the two outputs to connect the motor
A02/B02	Output 2 for channels A/B	Output	One of the two outputs to connect the motor

Now, for a quick overview of how to control each of the channels. If you are using an Arduino, don't worry about this too much as the library takes care of all of this for you. If you are using a different control platform, pay attention. When the outputs are set to High/Low your motor will run. When they are set to Low/High the motor will run in the opposite direction. In both cases, the speed is controlled by the PWM input.