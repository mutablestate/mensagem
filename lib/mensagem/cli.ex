defmodule Mensagem.CLI do
  @moduledoc """
  Print out random quotes, like the Unix fortune program,
  and reminders.
  """

  alias Mensagem.Quotes
  alias Mensagem.Remind

  def main(args) do
    args |> parse_args |> process
  end

  def parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean, quote: :boolean, remind: :boolean],
                                    aliases: [h: :help, q: :quote, r: :remind])

    case parse do
      {[help: true], _, _} -> :help
      {[quote: true], _, _} -> :quote
      {[remind: true], _, _} -> :remind
      _ -> []
    end
  end

  def process([]), do: Quotes.fetch_quote <> "\n\n" <> Remind.fetch_remind |> print_message

  def process(:quote), do: Quotes.fetch_quote |> print_message

  def process(:remind), do: Remind.fetch_remind |> print_message

  def process(:help) do
    IO.puts """
      Usage: mensagem

      without options: Print a random quote and reminders.

      Options:
        -h, --help: Print a help message.
        -q, --quote: Print a random quote.
        -r, --remind: Print reminders.
    """
    System.halt(0)
  end

  def print_message(message), do: IO.puts message

end
