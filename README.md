# Mime parser in Elixir

Practice in using Elixir metaprogramming to build a Mime parser

```elixir
defmodule MyMime do
  use Mime
end

MyMime.exts_from_type("text/html") => ["html", ".htm"]

MyMime.type_from_ext(".html") => "text/html"

MyMime.valid_type?("text/html") => true
```

# Defining custom types

pass it as options into use

```elixir
defmodule MyMime do
  use Mime, "text/emoji": [".emj"], "text/elixir": [".exs",".ex"]
end

```

# Running the test

Requires ExUnit to run the test

```elixir
elixir mime_test.exs
```
