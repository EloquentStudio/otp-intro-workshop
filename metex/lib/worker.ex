defmodule Metex.Worker do
  def temperature_of(location) do
    result = url_for(location) 
      |> HTTPoison.get
      |> parse_response
    
    case result do
      {:ok, temprature} ->
        "#{location}: #{temprature} ˚C"
      :error ->
        "#{location} not found"
    end
  end
  
  defp url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey()}"
  end
  
  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> compute_temprature
  end
  
  defp parse_response(_) do
    :error
  end
  
  defp compute_temprature(json) do
    try do
      temp = (json["main"]["temp"] - 273.15) |> Float.round(1)
      {:ok, temp}
    rescue
      _ -> :error
    end
  end
  
  defp apikey, do: "ff8b38f17bb390d6decb52d7b77ed4c1"
end

## Usage
# iex -S mix
# Metex.Worker.temperature_of "Delhi"

## Working with multiple cities
# iex -S mix
# cities = ["Delhi", "Mumbai", "Kolkata", "Chennai"]
# cities |> Enum.map(fn city -> Metex.Worker.temperature_of(city) end)
