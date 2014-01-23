defmodule PiBlaster do
  def set_pin(pin, value) do
    build_command(pin, value) |> bitstring_to_list |>:os.cmd
  end

  def build_command(pin, value) do
    "echo '#{pin}=#{value}' > /dev/pi-blaster"
  end
end
