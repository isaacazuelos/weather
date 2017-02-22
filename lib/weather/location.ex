defmodule Weather.Location do

  @moduledoc """
  This module is responsible for loading and working with the location file.
  """

  @file_path Path.join(System.get_env("HOME"), ".weather")

  @doc """
  Write a new file containing just the feed. This _will_ overwrite an existing
  file.
  """
  def save(feed, path \\ @file_path) do
    File.write(path, feed)
  end

  @doc """
  Read in the feel URL from the location file.
  """
  def get(path \\ @file_path) do
    path
    |> File.read()
    |> Result.map(&String.trim/1)
  end
end
