defmodule PinServer.Mixfile do
  use Mix.Project

  def project do
    [ app: :pin_server,
      version: "0.0.1",
      elixir: "~> 0.12.1-dev",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { PinServer, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:exactor, github: "sasa1977/exactor"},
      {:erlang_ale, github: "esl/erlang_ale"}
    ]
  end
end
