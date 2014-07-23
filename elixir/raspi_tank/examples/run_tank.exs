{:ok, s} = RaspiTank.Server.start("/dev/ttyACM0")
:erlang.register(:raspi_tank, s)
