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

### Using Distribution to control an RGB LED

Start one node on the raspberrypi with:

```shell
erl -name "raspi@192.168.1.46" -setcookie RASPI
```

Start one locally with

```shell
erl -name "laptop@192.168.1.22" -setcookie RASPI
```

On the `laptop` erl shell, run the following:

```erlang
Pid = spawn('raspi@192.168.1.46', rgb_led_server, do_start, [23, 24, 25])
% assuming pins 23, 24, 25 for red, green, blue respectively...
Pid ! {red, 1}.
Pid ! blast.
```

### Using Distribution to control an RGB LED with named processes

This one starts to be a bit more friendly w/r/t interoperating with JInterface
and the like...

```shell
erl -name "raspi@192.168.1.46" -setcookie RASPI
```

Start one locally with

```shell
erl -name "laptop@192.168.1.22" -setcookie RASPI
```

On the `raspi` erl shell, run the following:

```erlang
% assuming pins 23, 24, 25 for red, green, blue respectively...
{ok, Pid} = rgb_led_server:start(23, 24, 25).
register(rgb_led, Pid).
```

On the `laptop` erl shell, run the following:

```erlang
RasPi = 'raspi@192.168.1.46'.
{rgb_led, RasPi} ! {red, 1}.
{rgb_led, RasPi} ! blast.
```

#### With Elixir...

So in place of the laptop erl shell, let's run an elixir shell instead.  Type:

```shell
iex --name "laptop@192.168.1.22"
```

Then in the iex:
```elixir
:erlang.set_cookie(node(), :RASPI)
raspi = :"raspi@192.168.1.46"
send({:rgb_led, raspi}, {:red, 1})
send({:rgb_led, raspi}, :blast)
## NOTE: Elixir recently replaced the left arrow (<-) with the `send` function,
## if you aren't familiar with the new style Elixir messaging yet...
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
