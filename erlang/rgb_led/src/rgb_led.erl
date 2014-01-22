-module(rgb_led).
-export([init/3, set_value/3, pi_blast/1]).

-record(pin, {pin_number, value = 0}).
-record(rgb_led_component, {red, green, blue}).

init(Red, Green, Blue) ->
  #rgb_led_component{red   = #pin{pin_number = Red},
                     green = #pin{pin_number = Green},
                     blue  = #pin{pin_number = Blue}}.

pi_blast(Component) ->
  pi_blast(red,   Component),
  pi_blast(green, Component),
  pi_blast(blue,  Component).

set_value(Color, Value, Component) ->
  Pin = get_pin(Color, Component),
  NewPin = Pin#pin{value=Value},
  case Color of
    red   -> Component#rgb_led_component{red=NewPin};
    green -> Component#rgb_led_component{green=NewPin};
    blue  -> Component#rgb_led_component{blue=NewPin}
  end.

get_pin(Color, Component) ->
  case Color of
    red   -> Component#rgb_led_component.red;
    green -> Component#rgb_led_component.green;
    blue  -> Component#rgb_led_component.blue
  end.

get_value(Color, Component) ->
  Pin = get_pin(Color, Component),
  Pin#pin.value.

inverted_value(Value) ->
  1 - Value.

pi_blast(Color, Component) ->
  Pin = get_pin(Color, Component),
  pi_blaster:set_pin(Pin#pin.pin_number, inverted_value(Pin#pin.value)).

%%% Tests %%%
-include_lib("eunit/include/eunit.hrl").

get_value_test() ->
  RgbLed = init(1, 2, 3),
  0 = get_value(red, RgbLed).

set_value_test() ->
  RgbLed = init(1, 2, 3),
  RgbLed1 = set_value(red, 1, RgbLed),
  1 = get_value(red, RgbLed1).
