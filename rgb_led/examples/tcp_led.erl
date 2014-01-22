-module(tcp_led).
-export([start/4]).

start(Port, Red, Green, Blue) ->
  {ok, LSock} = gen_tcp:listen(Port, [binary, {packet, 0}, 
                                      {active, false}]),
  do_accept(LSock, {Red, Green, Blue}).

do_accept(LSock, {Red, Green, Blue}) ->
  {ok, Sock} = gen_tcp:accept(LSock),
  {ok, Pid} = rgb_led_server:start(Red, Green, Blue),
  do_recv(Sock, Pid),
  do_accept(LSock, {Red, Green, Blue}).

do_recv(Sock, Pid) ->
  case gen_tcp:recv(Sock, 0) of
    {ok, Data} ->
      handle_data(Data, Pid),
      do_recv(Sock, Pid);
    {error, closed} ->
      ok
  end.

handle_data(Data, Pid) ->
  {Red, Green, Blue} = extract_values(Data),
  Pid ! {update, [{red, Red}, {green, Green}, {blue, Blue}]},
  Pid ! blast.

extract_values(Data) ->
  {match, [Red, Green, Blue]} = re:run(Data, value_extractor(), [{capture, ['RED', 'GREEN', 'BLUE'], list}]),
  io:format("red: ~p, green: ~p, blue: ~p\n", [Red, Green, Blue]),
  {input_to_num(Red), input_to_num(Green), input_to_num(Blue)}.

value_extractor() ->
  "R(?<RED>[0-9.]+)G(?<GREEN>[0-9.]+)B(?<BLUE>[0-9.]+).*".

input_to_num(N) ->
  case string:to_float(N) of
    {error,no_float} -> list_to_integer(N);
    {F,_Rest} -> F
  end.
