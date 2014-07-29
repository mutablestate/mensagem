defmodule Mensagem.Remind do
  @moduledoc false

  def fetch_remind() do
    rem_path = Path.join(__DIR__, "Reminders.txt")
    #lines = File.read!(rem_path) |> String.split("\n", trim: true)
    text = File.read! rem_path

    case text do
      [] -> "No reminders."
      _ -> "Reminders for today.\n" <> text
    end
  end
end
