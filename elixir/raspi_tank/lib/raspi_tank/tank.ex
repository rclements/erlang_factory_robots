defmodule RaspiTank.Tank do
  alias RaspiTank.Motor

  def init(left, right) do
    left_motor = Motor.init(left)
    right_motor = Motor.init(right)
    {:tank, left_motor, right_motor}
  end

  def set_speed(left, right, {:tank, left_motor, right_motor}) do
    {:tank,
       Motor.set_speed(left, left_motor),
       Motor.set_speed(right, right_motor)}
  end

  def pi_blast({:tank, left_motor, right_motor}) do
    Motor.pi_blast(left_motor)
    Motor.pi_blast(right_motor)
  end
end
