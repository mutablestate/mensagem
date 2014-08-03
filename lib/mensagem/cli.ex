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
    parse = OptionParser.parse(args, switches: [help: :boolean, add: :boolean,
                            quotes: :boolean, remind: :boolean],
                            aliases: [h: :help, a: :add, q: :quotes, r: :remind])

    case parse do
      {[help: true], _, _} -> :help
      {[add: true], [date, message, offset], _} -> [:add, date, message, offset]
      {[add: true], [date, message], _} -> [:add, date, message]
      {[add: true], _, _} -> :help
      {[quotes: true], _, _} -> :quotes
      {[remind: true], _, _} -> :remind
      _ -> []
    end
  end

  def process([]), do: Quotes.fetch_quotes <> "\n\n" <> Remind.fetch_remind |> print_message

  def process([:add, date, message, offset]), do: Remind.add_remind(date, message, String.to_integer(offset))

  def process([:add, date, message]), do: Remind.add_remind(date, message)

  def process(:quotes), do: Quotes.fetch_quotes |> print_message

  def process(:remind), do: Remind.fetch_remind |> print_message

  def process(:help), do: print_usage

  def print_usage() do
    IO.puts """
      Usage: mensagem

      without options: Print a random quotes and reminders.

      Options:
        -h, --help: Print a help message.
        -a, --add: Add a reminder.
        -q, --quotes: Print a random quote.
        -r, --remind: Print reminders.

      Example command for adding a reminder for October 12:

      mensagem -a 10/12 "Feed the pet ant."

      If the reminder is for more than one year in the future:

      mensagem -a 2016/3/4 "Greet the wife."

      If you want the reminders shown before the date specified,
      add the number of days after the message:

      mensagem -a 11/14 "If the weather's OK, start the revolution" 4

      This message will be shown from 4 days before 14 Nov.
    """
    System.halt(0)
  end

  def print_message(message), do: IO.puts message

end
