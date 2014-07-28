defmodule Mensagem.CLI do
  @moduledoc """
  Print out random quotes like the Unix fortune program.
  """

  alias Mensagem.Quotes

  def main(args) do
    args |> parse_args |> process
  end

  def parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean],
                                    aliases: [h: :help])

    case parse do
      {[help: true], _, _} -> :help
      _ -> []
    end
  end

  def process([]), do: Quotes.fetch_quote |> print_quote

  def process(:help) do
    IO.puts """
      Usage: mensagem

      Options:
        -h, --help: Help!
    """
    System.halt(0)
  end

  def print_quote(quote), do: IO.puts quote

end
