defmodule PatternToRegexApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :pattern_to_regex_app,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Patter to regex app",
      source_url: "https://github.com/NickGowdy/pattern_to_regex_app",
      homepage_url: "https://github.com/NickGowdy/pattern_to_regex_app",
      docs: [
        # The main page in the docs
        main: "Program",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
