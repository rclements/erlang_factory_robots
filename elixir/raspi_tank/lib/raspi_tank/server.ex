defmodule RaspiTank.Server do
  @moduledoc """
  To start a Tank Server, just do:

      iex> {:ok, device} = RaspiTank.Server.start("/dev/ttyACM0")
      iex> device |> RaspiTank.Server.update(left_speed, right_speed)

  """

  use ExActor.GenServer
  alias RaspiTank.Tank

  definit(device_string) do
    Tank.init(device_string) |> initial_state
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
