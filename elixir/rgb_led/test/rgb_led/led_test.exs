defmodule RgbLed.LedTest do
  use ExUnit.Case
  alias RgbLed.Led

  test "get_value" do
    rgb_led = Led.init(1, 2, 3)
    assert 0 == Led.get_value(:red, rgb_led)
  end

  test "set_value" do
    rgb_led = Led.init(1, 2, 3)
           |> Led.set_value(:red, 1)
    assert 1 == Led.get_value(:red, rgb_led)
  end
end
