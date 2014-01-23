defmodule RgbLed.Led do
  defrecord Pin, number: nil, value: 0
  defrecord Component, [:red, :green, :blue]

  def init(red, green, blue) do
    Component[red: Pin[number: red],
              green: Pin[number: green],
              blue: Pin[number: blue]]
  end

  def pi_blast(component) do
    pi_blast(:red, component)
    pi_blast(:green, component)
    pi_blast(:blue, component)
  end

  def set_value(component, color, value) do
    pin = component |> get_pin(color)
    new_pin = pin.value(value)
    case color do
      :red   -> component.red(new_pin)
      :green -> component.green(new_pin)
      :blue  -> component.blue(new_pin)
    end
  end

  def get_pin(component, color) do
    IO.puts "component"
    IO.inspect component
    case color do
      :red   -> component.red
      :green -> component.green
      :blue  -> component.blue
    end
  end

  def get_value(component, color) do
    component |> get_pin(color).value
  end

  def inverted_value(value), do: 1 - value

  def pi_blast(component, color) do
    pin = component |> get_pin(color)
    PiBlaster.set_pin(pin.number, inverted_value(pin.value))
  end
end
