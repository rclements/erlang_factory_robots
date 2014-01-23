defmodule Rainbow do
  def run do
    {:ok, pid} = RgbLed.Server.start([23, 24, 25])
    values |> Enum.each(fn(vals) -> update(vals, pid) end)
  end

  defp update({red, green, blue}, pid) do
    send(pid, {:update, [red: red, green: green, blue: blue]})
    send(pid, :blast)
  end

  defp increments, do: [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
  defp values do
    lc red inlist increments,
       green inlist increments,
       blue inlist increments,
       do: {red, green, blue}
  end
end
