defmodule Mensagem.Remind do
  @moduledoc false

  def fetch_remind() do
    rems = get_remind

    case rems do
      [] -> "No reminders."
      _ -> "Reminders for today.\n" <> Enum.join(rems, "\n")
    end
  end

  def add_remind(date, message) do
    greg = date |> String.split("/") |> rem_date |> to_string
    rems = get_remind ++ [greg <> message] |> Enum.sort(&(&1 > &2))
    rem_path = Path.join(__DIR__, "reminders.txt")
    File.write!(rem_path, rems |> Enum.join("\n"))
  end

  defp get_remind() do
    rem_path = Path.join(__DIR__, "reminders.txt")
    lines = File.read!(rem_path) |> String.split("\n", trim: true)
  end

  defp date_today(), do: :erlang.date |> :calendar.date_to_gregorian_days

  defp rem_date(date) do
    case date do
      [year, month, day] -> {String.to_integer(year), String.to_integer(month), String.to_integer(day)} |> :calendar.date_to_gregorian_days
      _ -> date_today
    end
  end
end
