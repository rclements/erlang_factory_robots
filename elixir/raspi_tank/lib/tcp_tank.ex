defmodule TcpTank do
  alias RaspiTank.Server

  def start(port, left_pin, right_pin) do
    {:ok, lsock} = :gen_tcp.listen(port, [:binary, {:packet, 0}, 
                                         {:active, false}])
    do_accept(lsock, left_pin, right_pin)
  end

  def do_accept(lsock, left_pin, right_pin) do
    {:ok, sock} = :gen_tcp.accept(lsock)
    {:ok, pid} = Server.start([left_pin, right_pin])
    do_recv(sock, pid)
    do_accept(lsock, left_pin, right_pin)
  end

  def do_recv(sock, pid) do
    case :gen_tcp.recv(sock, 0) do
      {:ok, data} ->
        handle_data(data, pid)
        do_recv(sock, pid)
      {:error, :closed} ->
        :ok
    end
  end

  def handle_data(data, pid) do
    {left, right} = extract_values(data)
    pid |> Server.update(left, -1*right)
    pid |> Server.blast
  end

  def extract_values(data) do
    {:match, [left, right]} = :re.run(data, value_extractor(), [{:capture, ['LEFT', 'RIGHT'], :list}])
    {input_to_num(left), input_to_num(right)}
  end

  def value_extractor() do
    "L(?<LEFT>[0-9.\-]+)R(?<RIGHT>[0-9.\-]+).*"
  end

  def input_to_num(n) do
    case :string.to_float(n) do
      {:error,:no_float} -> list_to_integer(n)
      {f,_rest} -> f
    end
  end
end
