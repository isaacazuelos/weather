defmodule Result do
  @moduledoc """

  Monadic error handling for the `{:ok, _} | {:error, _}` pattern. The
  next function in the chain is placed second so that you can more
  easily work with the `|>` macro.

  Here's an example of how these could be used. The comments are the
  equivalents in Haskell's notation (this is `Data.Either`.)

  You'll have to capture the functions you'll be passing.

  ``` elixir
  x |> map(f)  == map(x, f)           # f <$> x
  x |> bind(f) == bind(x, f)          # x >>= f
  x |> unit    == unit(x) == {:ok, x} # return x, Right x
  x |> then(f) == then(x, f)          # x >> f
  ```
  """

  @doc """
  A functor instance for our result-handling monad. This maps over the `:ok`
  results, and can be used to modify results in ways that cannot `:error`.
  """
  def map({:ok, x}, f), do: {:ok, f.(x)}
  def map(e = {:error, _}, _), do: e

  @doc """
  Monadic bind for our results. Errors propogate through multiple
  `:error`s, and processing stops.
  """
  def bind({:ok, x}, f), do: f.(x)
  def bind(e = {:error, _}, _), do: e

  @doc """
  Preform the next action as you would with `bind`, only the result of
  the previous is discarded. You can express `then` as a type of
  `bind` where `x |> then(f)` is the same as
  `x |> bind(fn _ -> f.() end)`.
  """
  def then({:ok, _}, f), do: f.()
  def then({:error, e}, _), do: e

  @doc """
  Place a value into our monad, so that it can be used with `map` and
  `bind`. This isn't especially useful for this monad, but it's
  _technically_ a required part of the definition.
  """
  def unit(x), do: {:ok, x}

  @doc """
  A functor instance over the error. You can use this to transform
  errors into more useful resutls.
  """
  def map_error({:error, e}, f), do: {:error, f.(e)}
  def map_error(ok = {:ok, _}, _), do: ok
end
