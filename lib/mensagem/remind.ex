defmodule Mensagem.Remind do
  use Jazz

  def fetch_remind() do
    rems = get_remfile

    case rems do
      [] -> "No reminders.\n"
      _ -> "Reminders for today.\n" <> get_rem(rems, greg_date)
    end
  end

  def add_remind(date, reminder) do
    greg = date |> String.split("/") |> rem_date
    rems = Enum.into(get_remfile, [%{calendar: date, gregorian: greg, message: reminder}])
    rem_path = Path.join(__DIR__, "reminders.json")
    File.write!(rem_path, rems |> Enum.filter(fn x -> x.gregorian >= greg_date end) |> JSON.encode!)
  end

  defp get_remfile() do
    rem_path = Path.join(__DIR__, "reminders.json")
    File.read!(rem_path) |> JSON.decode!(keys: :atoms)
  end

  defp get_rem(rems, today) do
    rems |> Enum.filter(fn x ->
      x.gregorian < today + 4 and x.gregorian >= today end)
      |> Enum.map(fn y -> y.calendar <> " " <> y.message end)
      |> Enum.join("\n")
  end

  defp greg_date(date \\ :erlang.date), do: date |> :calendar.date_to_gregorian_days

  defp rem_date(date) do
    case date do
      [year, month, day] -> {to_int(year), to_int(month), to_int(day)} |> greg_date
      _ -> greg_date
    end
  end

  defp to_int(number), do: String.to_integer number

end
