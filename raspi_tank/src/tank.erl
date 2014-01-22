-module(tank).
-export([init/2, set_speed/3, pi_blast/1]).

init(Left, Right) ->
  LeftMotor = motor:init(Left),
  RightMotor = motor:init(Right),
  {tank, LeftMotor, RightMotor}.

set_speed(Left, Right, {tank, LeftMotor, RightMotor}) ->
  {tank,
    motor:set_speed(Left, LeftMotor),
    motor:set_speed(Right, RightMotor)}.

pi_blast({tank, LeftMotor, RightMotor}) ->
  motor:pi_blast(LeftMotor),
  motor:pi_blast(RightMotor).
