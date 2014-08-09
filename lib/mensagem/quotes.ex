defmodule Mensagem.Quotes do
  @moduledoc false

  @quotes_path Path.join(__DIR__, "quotes")

  def fetch_quotes(quotes_dir \\ @quotes_path) do
    file_list = File.ls!(quotes_dir)
    :random.seed(:erlang.now())
    quotes_file = Path.join(quotes_dir,
                length(file_list) |> :random.uniform |> :lists.nth(file_list))
    lines = File.read!(quotes_file) |> String.split("\n%\n", trim: true)
    length(lines) |> :random.uniform |> :lists.nth(lines)
  end
end
