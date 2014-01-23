defmodule TcpLed do
  alias RgbLed.Server

  def start(port, red, green, blue) do
    IO.puts "start"
    {:ok, lsock} = :gen_tcp.listen(port, [:binary, {:packet, 0}, 
                                         {:active, false}])
    do_accept(lsock, {red, green, blue})
  end

  def do_accept(lsock, {red, green, blue}) do
    IO.puts "do_accept"
    {:ok, sock} = :gen_tcp.accept(lsock)
    {:ok, pid} = Server.start([red, green, blue])
    do_recv(sock, pid)
    do_accept(lsock, {red, green, blue})
  end

  def do_recv(sock, pid) do
    IO.puts "do_recv"
    case :gen_tcp.recv(sock, 0) do
      {:ok, data} ->
        IO.puts "got #{data}"
        handle_data(data, pid)
        do_recv(sock, pid)
      {:error, :closed} ->
        :ok
    end
  end

  def handle_data(data, pid) do
    {red, green, blue} = extract_values(data)
    IO.inspect "handle data, red: #{red}"
    pid |> Server.update([red: red, green: green, blue: blue])
    pid |> Server.blast
  end

  def extract_values(data) do
    {:match, [red, green, blue]} = :re.run(data, value_extractor(), [{:capture, ['RED', 'GREEN', 'BLUE'], :list}])
    {input_to_num(red), input_to_num(green), input_to_num(blue)}
  end

  def value_extractor() do
    "R(?<RED>[0-9.]+)G(?<GREEN>[0-9.]+)B(?<BLUE>[0-9.]+).*"
  end

  def input_to_num(n) do
    case :string.to_float(n) do
      {:error,:no_float} -> list_to_integer(n)
      {f,_rest} -> f
    end
  end
end
