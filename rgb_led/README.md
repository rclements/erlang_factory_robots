# RGBLED

## Using the PiBlaster interface

```erlang
pi_blaster:set_pin(11, 1). % Set pin 11 to 100% on
```

## Using an RGB LED without state

```erlang
% assuming pins 23, 24, 25 for red, green, blue respectively...
RgbLed = rgb_led:init(23, 24, 25).
RgbLed1 = rgb_led:set_value(red, 1, RgbLed).
rgb_led:pi_blast(RgbLed1). % This updates their values...
```

## Using an RGB LED with state
```erlang
% assuming pins 23, 24, 25 for red, green, blue respectively...
{:ok, Pid} = rgb_led_server:start(23, 24, 25).
Pid ! {red, 1}.
Pid ! blast.
```
