# RGBLED

## Examples

### Using the PiBlaster interface

```erlang
pi_blaster:set_pin(11, 1). % Set pin 11 to 100% on
```

### Using an RGB LED without state

```erlang
% assuming pins 23, 24, 25 for red, green, blue respectively...
RgbLed = rgb_led:init(23, 24, 25).
RgbLed1 = rgb_led:set_value(red, 1, RgbLed).
rgb_led:pi_blast(RgbLed1). % This updates their values...
```

### Using an RGB LED with state

```erlang
% assuming pins 23, 24, 25 for red, green, blue respectively...
{:ok, Pid} = rgb_led_server:start(23, 24, 25).
Pid ! {red, 1}.
Pid ! blast.
```

### To cycle the LED through a lot of pretty colors

```erlang
c('examples/rainbow.erl').
rainbow:start().
```

### To run a TCP server for an RGB LED

```erlang
c('examples/tcp_led.erl').
tcp_led:start(23, 24, 25).
```

Then you can connect to the TCP server running on port 5678 and send it commands
like:

```
R1G1B1
R0G0B0
R1G0B0
R0.5G0.5B0
```
