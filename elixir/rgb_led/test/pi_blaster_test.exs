defmodule PiBlaster.Test do
  use ExUnit.Case

  test "build command" do
    assert "echo '11=0' > /dev/pi-blaster" = PiBlaster.build_command(11, 0)
  end
end
