defmodule Metex.Worker do
  use GenServer

  def temperature_of(location) do
    result =
      location
      |> url_for()
      |> HTTPoison.get()
      |> parse_response()

    case result do
      {:ok, temp} ->
        "#{location}: #{temp}C"

      :error ->
        "#{location} not found"
    end
  end

  defp url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey}"
  end

  defp parse_response(_) do
    :error
  end

  defp compute_temperature(json) do
    try do
      temp =
        (json["main"]["temp"] - 273.15)
        |> Float.round(1)

      {:ok, temp}
    rescue
      _ -> :error
    end
  end

  defp apikey do
    Application.get_env(:my_app, :api_key)
  end
end
