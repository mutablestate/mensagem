defmodule Mensagem.Quotes do
  @moduledoc false

  def fetch_quote() do
    quote_dir = Path.join(__DIR__, "quotes")
    file_list = File.ls! quote_dir
    :random.seed(:erlang.now())
    quote_file = Path.join(quote_dir, :lists.nth(:random.uniform(length file_list), file_list))
    lines = String.split(File.read!(quote_file), "\n%\n", trim: true)
    :lists.nth(:random.uniform(length lines), lines)
  end

  def fetch_remind() do
    rem_path = Path.join(__DIR__, "Reminders.txt")
    lines = String.split(File.read!(rem_path), "\n", trim: true)
  end
end
