defmodule PinFun do

  def init do
    :gpio_sup.start_link([{25, :output}])
  end

  def on do
    :gpio.write(25, 1)
  end

  def off do
    :gpio.write(25, 0)
  end

  def blink(_gap, 0) do
    :io.format('Done!')
  end
  
  def blink(gap, number) do
    blink_once(gap)
    blink(gap, number-1)
  end

  def blink_once(gap) do
    on
    :timer.sleep(gap)
    off
    :timer.sleep(gap)
  end


"""
  %%% README %%%
  %%% make shell
  %%% c('../erlang_factory_robots/erlang/pin_fun/pin_fun.ex')
  %%% pin_fun.init
  %%% pin_fun.blink(2000, 5)
"""
end
