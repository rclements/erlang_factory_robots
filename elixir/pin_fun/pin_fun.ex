defmodule PinFun do
  def blink do
    :gpio_sup.start_link([{25, :output}])
    :gpio.write(25, 1)
    :timer.sleep(1000)
    :gpio.write(25, 0)
  end
end
