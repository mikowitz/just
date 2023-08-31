defmodule Just.MixProject do
  use Mix.Project

  def project do
    [
      app: :just,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:credo, "~> 1.7", only: [:test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:test], runtime: false},
      {:ex_doc, "~> 0.30", runtime: false},
      {:mix_test_watch, "~> 1.0", only: [:test], runtime: false},
      {:rodiex,
       git: "https://github.com/mikowitz/rodiex", ref: "a57e394946e11155537facda5841cbb5a5dd8c0a"}
    ]
  end
end
