defmodule RgbLed.Server do
  use ExActor
  alias RgbLed.Led

  def init([red, green, blue]) do
    Led.init(red, green, blue) |> initial_state
  end

  defcast update(values), state: state do
    do_update(values, state) |> new_state
  end
  defcast red(value), state: state do
    IO.puts "red!, #{value}"
    state |> Led.set_value(:red, value) |> new_state
  end
  defcast green(value), state: state do
    IO.puts "green, #{value}"
    state |> Led.set_value(:green, value) |> new_state
  end
  defcast blue(value), state: state do
    IO.puts "blue, #{value}"
    state |> Led.set_value(:blue, value) |> new_state
  end
  defcast blast, state: state do
    IO.puts "blast"
    state |> Led.pi_blast
  end

  defp do_update([], state), do: state
  defp do_update([h|t], state) do
    new_state = do_update(h, state)
    do_update(t, new_state)
  end
  defp do_update({color, value}, state) do
    state |> Led.set_value(color, value)
  end
end
