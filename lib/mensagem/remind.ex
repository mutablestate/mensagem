defmodule Mensagem.Remind do
  @moduledoc false

  def fetch_remind() do
    rems = get_remfile

    case rems do
      [] -> "No reminders.\n"
      _ -> "Reminders for today.\n" <> get_rem(rems, greg_date)
    end
  end

  def add_remind(date, message) do
    greg = date |> String.split("/") |> rem_date |> to_string
    rems = get_remfile ++ [greg <> "::" <> message] |> Enum.sort
            |> Enum.drop_while(fn x -> split_to_int(x) < greg_date end)
    rem_path = Path.join(__DIR__, "reminders.txt")
    File.write!(rem_path, rems |> Enum.join("\n"))
  end

  defp get_remfile() do
    rem_path = Path.join(__DIR__, "reminders.txt")
    File.read!(rem_path) |> String.split("\n", trim: true)
  end

  defp get_rem(rems, today) do
    rems |> Enum.filter(fn x -> split_to_int(x) < today + 4
          and split_to_int(x) >= today end) |> Enum.join("\n")
  end

  defp greg_date(date \\ :erlang.date), do: date |> :calendar.date_to_gregorian_days

  defp cal_date(greg), do: greg |> :calendar.gregorian_days_to_date

  defp rem_date(date) do
    case date do
      [year, month, day] -> {to_int(year), to_int(month), to_int(day)} |> greg_date
      _ -> greg_date
    end
  end

  defp split_to_int(line), do: String.split(line, "::") |> hd |> String.to_integer

  defp to_int(number), do: String.to_integer number

end
