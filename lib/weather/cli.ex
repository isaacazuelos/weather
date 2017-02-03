defmodule Weather.CLI do

  @moduledoc """
  Handle the command line options for the `weather` app, which prints
  the current weather.
  """

  @usage "Usage: weather [-h|--help]"
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
  - `nil` gets the weather
  """
  def process(:usage), do: IO.puts(@usage)
  def process(:help), do: IO.puts(@help)
  def process(nil) do
    case Weather.Data.fetch() |> Result.map(&Weather.Data.current/1) do
      {:ok,    c} -> IO.puts c
      {:error, _} -> IO.puts "error!"
    end
  end

  @doc """
  The list `args` can contain `-h` or `--help`, which prints help. It
  returns `:help` if the help message is required, and `nil` if
  everything is fine. If there are too many arguments, it returns
  `:usage`.
  """
  def parse_args(args) do
    parse = OptionParser.parse(
      args,
      switches: [ help: :boolean ],
      aliases:  [ h: :help ])

    case parse do
      { [ help: true ], _, _ } -> :help
      { [], [], [] } -> nil
      _ -> :usage
    end
  end
end
