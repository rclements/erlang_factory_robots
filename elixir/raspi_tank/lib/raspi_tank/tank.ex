defmodule RaspiTank.Tank do
  def init(device_string) do
    ArduinoMotorDriver.start(device_string)
  end

  def set_speed(left, right, device) do
    ArduinoMotorDriver.left(device, left)
    ArduinoMotorDriver.right(device, right)
  end

  def pi_blast({:tank, left_motor, right_motor}) do
    # LOL NOPE
  end
end
