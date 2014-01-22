-module(pi_blaster).
-export([set_pin/2]).

set_pin(Pin, Value) ->
  os:cmd(build_command(Pin, Value)).

build_command(Pin, Value) ->
  string_format("echo '~p=~p' > /dev/pi-blaster", [Pin, Value]).

%%% Utilities %%%
string_format(Pattern, Values) ->
  lists:flatten(io_lib:format(Pattern, Values)).

%%% Tests %%%
-include_lib("eunit/include/eunit.hrl").

build_command_test() ->
  "echo '11=0' > /dev/pi-blaster" = build_command(11, 0).
