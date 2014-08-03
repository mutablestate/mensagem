defmodule Mensagem.Mixfile do
  use Mix.Project

  def project do
    [app: :mensagem,
    version: "0.0.2",
    elixir: "~> 0.14.3",
    escript: escript,
    deps: deps]
  end

  def escript do
    [main_module: Mensagem.CLI]
  end

  defp deps do
    [{:jazz, "~> 0.1.2"}]
  end
end
