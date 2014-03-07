-module(tcp_tank).
-export([start/3]).

start(Port, LeftPin, RightPin) ->
  {ok, LSock} = gen_tcp:listen(Port, [binary, {packet, 0},
                                      {active, false}]),
  do_accept(LSock, LeftPin, RightPin).

do_accept(LSock, LeftPin, RightPin) ->
  {ok, Sock} = gen_tcp:accept(LSock),
  {ok, Pid} = tank_server:start(LeftPin, RightPin),
  do_recv(Sock, Pid),
  do_accept(LSock, LeftPin, RightPin).

do_recv(Sock, Pid) ->
  case gen_tcp:recv(Sock, 0) of
    {ok, Data} ->
      handle_data(Data, Pid),
      do_recv(Sock, Pid);
    {error, closed} ->
      ok
  end.

handle_data(Data, Pid) ->
  {Left, Right} = extract_values(Data),
  Pid ! {update, Left, -1*Right},
  Pid ! blast.

extract_values(Data) ->
  {match, [Left, Right]} = re:run(Data, value_extractor(), [{capture, ['LEFT', 'RIGHT'], list}]),
  io:format("left: ~p, right: ~p\n", [Left, Right]),
  {input_to_num(Left), input_to_num(Right)}.

value_extractor() ->
  "L(?<LEFT>[0-9.\-]+)R(?<RIGHT>[0-9.\-]+).*".

input_to_num(N) ->
  case string:to_float(N) of
    {error,no_float} -> list_to_integer(N);
    {F,_Rest} -> F
  end.
