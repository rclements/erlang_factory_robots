{:ok, s} = RaspiTank.Server.start([23, 24])
:erlang.register(:raspi_tank, s)
