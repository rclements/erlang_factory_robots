-module(motor).
-author('josh@isotope11.com').

-export([init/1, set_speed/2, pi_blast/1]).

-record(pin, {pin_number, value = 0}).

init(Motor) ->
  #pin{pin_number = Motor}.

%% set_speed takes a number between -1 and 1 and will map it to
%% the appropriate values for a Sabretooth RC.

set_speed(Value, Pin) ->
  NewValue = mapped_value_for(Value),
  Pin#pin{value=NewValue}.

pi_blast(#pin{pin_number=PinNumber, value=Value}) ->
  pi_blaster:set_pin(PinNumber, Value).

% Maps a value from -1 to 1 to the appropriate value to drive a
% Sabretooth RC, assuming 1 is all the way forward and -1 is all
% the way backwards.
mapped_value_for(Value) ->
  idle() + (Value * 500)/max_pulse_width().

idle() ->
  1500 / max_pulse_width().

max_pulse_width() ->
  10000.
