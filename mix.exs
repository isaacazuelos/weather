defmodule Weather.Mixfile do
  use Mix.Project

  def project do
    [app: :weather,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript_config(),
     name: "weather",
     source_url: "https://github.com/isaacazuelos/weather",
     deps: deps()]
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11"},
      {:sweet_xml, "~> 0.6.4"}
    ]
  end

  defp escript_config do
    [ main_module: Weather.CLI ]
  end
end
