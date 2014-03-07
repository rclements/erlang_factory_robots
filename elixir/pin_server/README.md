# PinServer

```sh
{:ok, s} = PinServer.Server.start(25)
:erlang.register(:led, s)
```

You can run it on a node thusly:

```
iex --name "server@192.168.1.10" --cookie test \
    -pa _build/dev/lib/pin_server/ebin/ \
    -pa _build/dev/lib/exactor/ebin/
```

Then the Android app can talk to the server.
