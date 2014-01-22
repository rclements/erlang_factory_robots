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

### Using a tank without state

```erlang
% assuming the left motor's on pin 23 and the right motor's on 24
Tank = tank:init(23, 24).
Tank1 = tank:set_speed(1, 1, Tank) % all the way forward
tank:pi_blast(Tank1).
Tank2 = tank:set_speed(-1, -1, Tank1) % all the way backward
tank:pi_blast(Tank2).
```
