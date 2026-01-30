defmodule Negotiator.MixProject do
  use Mix.Project

  def project do
    [
      app: :negotiator,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Negotiator",
      source_url: "https://github.com/alexander-schoch-linuxdays/negotiator"
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Library for content negotiation in web applications."
  end

  defp package do
    [
      name: "negotiator",
      licenses: ["MIT"],
      files: ~w(lib test .formatter.exs mix.exs README*),
      links: %{"GitHub" => "https://github.com/alexander-schoch-linuxdays/negotiator"}
    ] 
  end
end
