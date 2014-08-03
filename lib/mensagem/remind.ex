defmodule Mensagem.Remind do
  use Jazz

  rem_path = Path.join(__DIR__, "reminders.json")

  def fetch_remind() do
    rems = get_remfile
    case rems do
      [] -> "No reminders.\n"
      _ -> get_remind(rems, greg_date)
    end
  end

  def add_remind(date, text, diff \\ 3) do
    {year, month, day, greg} = date |> rem_date
    File.write!(unquote(rem_path), Enum.into(get_remfile,
      [%{year: year, month: month, day: day, offset: diff, num_days: greg, message: text}])
      |> Enum.filter(&(&1.num_days >= greg_date)) |> JSON.encode!)
  end

  defp get_remfile() do
    File.read!(unquote(rem_path)) |> JSON.decode!(keys: :atoms)
  end

  defp get_remind(rems, today) do
    rem_message = rems
      |> Enum.filter(&(&1.num_days < today + &1.offset and &1.num_days >= today))
      |> Enum.map(&(&1.day <> " " <> &1.month <> " " <> &1.message))
      |> Enum.sort |> Enum.join("\n")
    case rem_message do
      "" -> "No reminders.\n"
      _ -> "Reminders for today.\n" <> rem_message
    end
  end

  defp rem_date(date) do
    dt = {year, month, day} = date |> parse_date
    if dt |> greg_date < greg_date, do: year = year + 1
    greg = {year, month, day} |> greg_date
    month_names = %{1 => "Jan", 2 => "Feb", 3 => "Mar", 4 => "Apr", 5 => "May", 6 => "Jun",
    7 => "Jul", 8 => "Aug", 9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dec"}
    month = month_names[month]
    {year, month, to_string(day), greg}
  end

  defp fmt_date(date) do
  end

  defp parse_date(date) do
    {this_year, _, _} = :erlang.date
    case date |> String.split("/") do
      [year, month, day] -> {to_int(year), to_int(month), to_int(day)}
      [month, day] -> {this_year, to_int(month), to_int(day)}
      _ -> IO.puts "There seems to be a problem with the date."
    end
  end

  defp greg_date(date \\ :erlang.date), do: date |> :calendar.date_to_gregorian_days

  defp to_int(number), do: String.to_integer number

end
