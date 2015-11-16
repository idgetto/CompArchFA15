Specification Document
======================

![basic-schematic](img/Bike-Light-Schematic-Basic.png)

This document serves to specify the behavior of a bike light LED controller.

### I/O ###

This device takes one input and sends one output. The controller receives data in the form of a push button. The output of the controller illiminates an LED.

### Operational Modes ###

The device has four operational modes. These include "Off", "On", "Blinking", and "Dim". Each time the input button is pressed, the device will operate in the next mode. Once the device has reached the last mode, it will then cycle back to the first mode the next time the button is pressed. These modes can be visualized with the following figures.

#### Off ####

In this mode the bike light is always off.

![mode-0-off](img/mode0.png)

#### On ####

In this mode the bike light is always on.

![mode-1-on](img/mode1.png)

#### Blinking ####

In this mode the bike light flashes at 16 Hz.

![mode-2-blink](img/mode2.png)

#### Dim ####

In this mode the bike light is on at 50% brightness.

![mode-2-dim](img/mode3.png)

The previous timing diagrams used a clock speed of 64 Hz. This was simply to make the timing diagrams smaller and easier to interpret. A real implementation of this bike light controller should use a clock speed much faster than the human visual system can process.

TODO: Put images of each mode here

#### Finite State Machine ####

This finite state machine describes the states in which the controller can operate and the signals that cause a change of state.

![FSM-Diagram](img/FSM-Diagram.png)

### Measurements ###

TODO: Think of measurements to put here
- blinking frequency
- input conditioner timing
