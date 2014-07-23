# RaspiTank

In `examples/run_tank.exs` you'll find:

```sh
{:ok, s} = RaspiTank.Server.start("ttyACM0")
:erlang.register(:raspi_tank, s)
```

You can run it on a node thusly:

```
iex --name "server@192.168.1.10" --cookie test \
    -pa _build/dev/lib/raspi_tank/ebin/ \
    -pa _build/dev/lib/exactor/ebin/ \
    -r examples/run_tank.exs
```

Then the Android app can talk to the server.
