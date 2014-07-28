defmodule Mensagem.Quotes do
  @moduledoc false

  def fetch_quote() do
    quote_dir = Path.join(__DIR__, "quotes")
    file_list = File.ls! quote_dir
    :random.seed(:erlang.now())
    quote_file = Path.join(quote_dir,
                length(file_list) |> :random.uniform |> :lists.nth(file_list))
    lines = File.read!(quote_file) |> String.split("\n%\n", trim: true)
    length(lines) |> :random.uniform |> :lists.nth(lines)
  end

  def fetch_remind() do
    rem_path = Path.join(__DIR__, "Reminders.txt")
    lines = File.read!(rem_path) |> String.split("\n", trim: true)
  end
end
