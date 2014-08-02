defmodule Mensagem.Quotes do
  @moduledoc false

  def fetch_quotes() do
    quotes_dir = Path.join(__DIR__, "quotes")
    file_list = File.ls! quotes_dir
    :random.seed(:erlang.now())
    quotes_file = Path.join(quotes_dir,
                length(file_list) |> :random.uniform |> :lists.nth(file_list))
    lines = File.read!(quotes_file) |> String.split("\n%\n", trim: true)
    length(lines) |> :random.uniform |> :lists.nth(lines)
  end
end
