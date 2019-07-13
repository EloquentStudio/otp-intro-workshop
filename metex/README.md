# Metex

Step1: `mix new metex`

Step2: `cd metex`

Step3: `mix test`

# Add dependencies

```mix.exs
defp deps do 
  [
    {:httpoison, "~> 0.9.0"},
    {:json,      "~> 0.3.0"}
  ]
end
```

```
def application do
  [
    extra_applications: [:logger, :httpoison]
  ]
end
```

Run `mix deps.get`


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `metex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:metex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/metex](https://hexdocs.pm/metex).
