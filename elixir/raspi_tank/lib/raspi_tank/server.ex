defmodule Server do
  @moduledoc """
  To start a Tank Server, just do:

      iex> {:ok, pid} = RaspiTank.Server.start(23, 24)
      iex> pid |> RaspiTank.Server.update(left_speed, right_speed)
      iex> pid |> RaspiTank.Server.blast

  """

  use ExActor
  alias RaspiTank.Tank

  def init([left_pin, right_pin]) do
    Tank.init(left_pin, right_pin) |> initial_state
  end

  defcast update(left_speed, right_speed), state: state do
    Tank.set_speed(left_speed, right_speed, state) |> new_state
  end

  defcast blast, state: state do
    state |> Tank.pi_blast
  end
end
