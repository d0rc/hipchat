defmodule Hipchat.Mixfile do
  use Mix.Project

  def project do
    [app: :hipchat,
     version: "0.0.1",
     deps: deps]
  end

  def application do
    [applications: [:sweetconfig, :httpoison, :jazz]]
  end

  defp deps do
    [
      {:httpoison, github: "d0rc/httpoison", branch: "fixed"},
      {:sweetconfig, github: "d0rc/sweetconfig"},
      {:jazz, github: "d0rc/jazz", branch: "v0.14.1"}
    ]
  end
end
