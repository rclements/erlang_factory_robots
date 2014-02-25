# RgbLed

Run this:

```sh
iex --name "server@192.168.1.10" --cookie test -pa _build/shared/lib/rgb_led/ebin/ -pa _build/shared/lib/exactor/ebin/
```

Then:

```elixir
{:ok, s} = RgbLed.Server.start([23, 24, 25])
:erlang.register(:rgbled, s)
```

Then the Android app can talk to the server.
