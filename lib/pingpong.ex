defmodule Metex.PingPong do
  def loop do
    receive do
      {sender_pid, :ping} ->
        :timer.sleep(1000)
        IO.puts("pong")
        send(sender_pid, {self(), :pong})

      {sender_pid, :pong} ->
        :timer.sleep(1000)
        IO.puts("ping")
        send(sender_pid, {self(), :ping})
    end
    loop()
  end
end
