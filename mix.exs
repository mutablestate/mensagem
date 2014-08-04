defmodule Mensagem.Mixfile do
  use Mix.Project

  def project do
    [app: :mensagem,
    version: "0.0.3",
    elixir: "~> 0.15.0",
    escript: escript,
    deps: deps]
  end

  def escript do
    [main_module: Mensagem.CLI]
  end

  defp deps do
    [{:jazz, "0.2.0"}]
  end
end
