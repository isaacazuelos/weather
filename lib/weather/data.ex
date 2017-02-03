defmodule Weather.Data do

  @moduledoc """
  This module works with the government of canada's weather service to get data
  about the current weather out of their atom feeds.
  """

  @user_agent [{"User-agent", "weather isaac@azuelos.ca"}]
  @feed "https://weather.gc.ca/rss/city/ab-52_e.xml"

  @doc """
  Fetch the data out of the feel url
  """
  def fetch(url) do
    url
    |> HTTPoison.get(@user_agent)
    |> Result.map(fn res -> res.body end)
    |> Result.map(&SweetXml.parse/1)
  end

  @doc """
  Extract the current condition out of the fetched feed.
  """
  def current(data) do
    import SweetXml
    data |> SweetXml.xpath(~x"//entry[3]/title/text()")
  end
end
