defmodule RaspiTank.Server do
  @moduledoc """
  To start a Tank Server, just do:

      iex> {:ok, pid} = RaspiTank.Server.start(23, 24)
      iex> pid |> RaspiTank.Server.update(left_speed, right_speed)
      iex> pid |> RaspiTank.Server.blast

  """

  use ExActor.GenServer
  alias RaspiTank.Tank

  definit([left_pin, right_pin]) do
    Tank.init(left_pin, right_pin) |> initial_state
  end

  defcast update(left_speed, right_speed), state: state do
    IO.puts "update(#{left_speed}, #{right_speed})"
    Tank.set_speed(left_speed, right_speed, state) |> new_state
  end

  defcast blast, state: state do
    state |> Tank.pi_blast
    noreply
  end
end
