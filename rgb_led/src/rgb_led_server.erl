-module(rgb_led_server).
-export([start/3, do_start/3]).

start(Red, Green, Blue) ->
  {ok, spawn(?MODULE, do_start, [Red, Green, Blue])}.

do_start(Red, Green, Blue) ->
  await(rgb_led:init(Red, Green, Blue)).

await(Component) ->
  receive
    {update, Values} ->
      Component1 = do_update(Values, Component),
      await(Component1);
    {Color, Value} ->
      await(rgb_led:set_value(Color, Value, Component));
    blast ->
      rgb_led:pi_blast(Component),
      await(Component)
  end.

do_update([], Component) ->
  Component;
do_update([H|T], Component) ->
  Component1 = do_update(H, Component),
  do_update(T, Component1);
do_update({Color, Value}, Component) ->
  rgb_led:set_value(Color, Value, Component).
