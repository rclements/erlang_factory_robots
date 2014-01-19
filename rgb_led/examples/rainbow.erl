-module(rainbow).
-export([run/0]).

run() ->
  Increments = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1],
  Values = [ {Red,Green,Blue} || 
                Red   <- Increments,
                Green <- Increments,
                Blue  <- Increments
           ],

  {ok, Pid} = rgb_led_server:start(23, 24, 25),
  [ update(Vals, Pid) || Vals <- Values ].

update({Red, Green, Blue}, Pid) ->
  Pid ! {update, [{red, Red}, {green, Green}, {blue, Blue}]},
  Pid ! blast.
