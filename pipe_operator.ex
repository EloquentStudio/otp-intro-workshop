# Daily Run

defmodule URLWorker do
  def start(url) do
    do_request(HTTPoison.get(url))
  end
end


# Mentos Run
defmodule URLWorker do
  def start(url) do
   result = url |> HTTPoison.get |> do_request
  end
end 
