defmodule PinServer.Server do
  use ExActor.GenServer

  definit(pin) do
    :gpio_sup.start_link([{pin, :output}])
    initial_state({0, pin})
  end

  defcast toggle, state: {0, pin} do
    :gpio.write(pin, 1)
    new_state({1, pin})
  end
  defcast toggle, state: {1, pin} do
    :gpio.write(pin, 0)
    new_state({0, pin})
  end
end
