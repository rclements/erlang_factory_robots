# RasPiTank

This is an erlang module for interfacing with a tank running on a couple of pwm
pins on the raspberry pi.

## Examples

### Using an motor without state

```erlang
% assuming the motor's on pin 23
Motor = motor:init(23).
Motor1 = motor:set_speed(1, Motor) % all the way forward
motor:pi_blast(Motor1).
Motor2 = motor:set_speed(-1, Motor1) % all the way backward
motor:pi_blast(Motor2).
```
