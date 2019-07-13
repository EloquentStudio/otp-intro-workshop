# Elixir uses the equals operator (=) to perform pattern matching.
a = 4
4 = a
a = a
4 = 5

# Destructuring
%{joe: a, jose: b, matz: c, rich: d} = %{joe: "Erlang", jose: "Elixir", matz: "Ruby", rich: "Clojure"}
