defmodule RaspiTank.Motor do
  defrecord Pin, number: nil, value: nil

  def init(pin), do: Pin[number: pin]

  def set_speed(value, pin) do
    mapped_value_for(value) |> pin.value
  end

  def pi_blast(Pin[number: number, value: value]) do
    PiBlaster.set_pin(number, value)
  end

  defp mapped_value_for(value) do
    idle + (value * 500)/max_pulse_width
  end

  defp idle, do: 1_500 / max_pulse_width
  defp max_pulse_width, do: 10_000
end
