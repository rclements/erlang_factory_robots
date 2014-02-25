-module(pin_fun).

-export([init/0, on/0, off/0, blink/2]).

init() ->
  gpio_sup:start_link([{25, output}]).

on() ->
  gpio:write(25, 1).

off() ->
  gpio:write(25, 0).

blink(_Gap, 0) ->
  io:format('Done!');
blink(Gap, Number) ->
  blink_once(Gap),
  blink(Gap, Number-1).

blink_once(Gap) ->
  on(),
  timer:sleep(Gap),
  off(),
  timer:sleep(Gap).

  %%% README %%%
  %%% make shell
  %%% c(pin_fun).
  %%% pin_fun:init().
  %%% pin_fun:blink(2000, 5).
