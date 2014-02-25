# RaspiTank

Run this:

```sh
iex --name "server@192.168.1.10" --cookie test -pa _build/dev/lib/raspi_tank/ebin/ -pa _build/dev/lib/exactor/ebin/
```

Then:

```elixir
{:ok, s} = RaspiTank.Server.start([23, 24])
:erlang.register(:raspi_tank, s)
```

Then the Android app can talk to the server.
