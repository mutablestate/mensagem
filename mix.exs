defmodule Mensagem.Mixfile do
  use Mix.Project

  def project do
    [app: :mensagem,
     version: "0.0.1",
     elixir: "~> 0.14.3",
     escript: escript]
  end

  def escript do
    [main_module: Mensagem.CLI]
  end
end
