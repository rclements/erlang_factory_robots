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
    Led.set_value(:red, value, state) |> new_state
  end
  defcast green(value), state: state do
    Led.set_value(:green, value, state) |> new_state
  end
  defcast blue(value), state: state do
    Led.set_value(:blue, value, state) |> new_state
  end
  defcast blast, state: state do
    Led.pi_blast(state) |> new_state
  end

  defp do_update([], state), do: state
  defp do_update([h|t], state) do
    new_state = do_update(h, state)
    do_update(t, new_state)
  end
  defp do_update({color, value}, state) do
    IO.inspect "do_update {#{color}, #{value}}, #{state}"
    state |> Led.set_value(color, value)
  end
end
