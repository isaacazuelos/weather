defmodule Weather.CLI do

  alias Weather.Data, as: Data
  alias Weather.Location, as: Location

  @moduledoc """
  Handle the command line options for the `weather` app, which prints the
  current weather.
  """

  @usage "Usage: weather [-h|--help] [--init url]"
  @help """
    #{@usage}

    Available Options:
      -h, --help    Show this message
  """

  @doc """
  The starting point of our program.
  """
  def main(args) do
    args |> parse_args |> process
  end

  @doc """
  Process the parsed arguments.
  - `:help` prints the help message
  - `:usage` print usage
  - `{:init, url}` saves the feed url.
  - `nil` gets the weather
  """
  def process(:usage), do: IO.puts(@usage)
  def process(:help),  do: IO.puts(@help)
  def process({:init, url}) do
    case Location.save(url) do
      :ok -> IO.puts "location saved!"
      {:error, :enoent} -> IO.puts "unable to create file"
    end
  end
  def process(nil) do
    current = Location.get()
    |> Result.bind(&Data.fetch/1)
    |> Result.map(&Data.current/1)

    case current do
      {:ok,    c}       -> IO.puts c
      {:error, :enoent} -> IO.puts "error: no .weather file found"
      {:error, _}       -> IO.puts "error: unknown error"
    end
  end

  @doc """

  The list `args` can contain `-h` or `--help`, which prints help. It returns
  `:help` if the help message is required, and `nil` if everything is fine. If
  there are too many arguments, it returns `:usage`.
  """
  def parse_args(args) do
    parse = OptionParser.parse(
      args,
      switches: [help: :boolean, init: :string],
      aliases:  [h: :help])

    case parse do
      {[help: true], _, _} -> :help
      {[init: s], [], []} -> {:init, s}
      {[], [], []} -> nil
      _ -> :usage
    end
  end
end
