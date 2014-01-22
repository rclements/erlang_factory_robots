defmodule PiBlaster do
  def set_pin(pin, value) do
    IO.inspect "#{build_command(pin, value)}"
    build_command(pin, value) |> :os.cmd
  end

  def build_command(pin, value) do
    "echo '#{pin}=#{value}' > /dev/pi-blaster"
  end
end
