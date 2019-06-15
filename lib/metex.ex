defmodule Metex do
  def temperatures_of(cities) do
    coordinator_pid = spawn(Metex.Coordinator, :loop, [[], Enum.count(cities)])

    cities
    |> Enum.each(fn city ->
      worker_pid = spawn(Metex.Worker, :loop, [])
      send(worker_pid, {coordinator_pid, city})
    end)
  end

  def pingpong do
    first = spawn(Metex.PingPong, :loop, [])
    second = spawn(Metex.PingPong, :loop, [])

    send(first, {second, :ping})
  end
end
