-module(tank_server).
-export([start/2, do_start/2]).

start(LeftPin, RightPin) ->
  {ok, spawn(?MODULE, do_start, [LeftPin, RightPin])}.

do_start(LeftPin, RightPin) ->
  await(tank:init(LeftPin, RightPin)).

await(Tank) ->
  receive
    {update, LeftSpeed, RightSpeed} ->
      Tank1 = tank:set_speed(LeftSpeed, RightSpeed, Tank),
      await(Tank1);
    blast ->
      tank:pi_blast(Tank),
      await(Tank)
  end.
