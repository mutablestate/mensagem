defmodule Mensagem.Remind do
  use Jazz

  def fetch_remind() do
    rems = get_remfile

    case rems do
      [] -> "No reminders.\n"
      _ -> "Reminders for today.\n" <> get_rem(rems, greg_date)
    end
  end

  def add_remind(date, text, diff \\ 3) do
    {year, month, day, greg} = date |> rem_date
    rem_path = Path.join(__DIR__, "reminders.json")
    File.write!(rem_path, Enum.into(get_remfile,
      [%{year: year, month: month, day: day, offset: diff, num_days: greg, message: text}])
      |> Enum.filter(fn x -> x.num_days >= greg_date end) |> JSON.encode!)
  end

  defp get_remfile() do
    rem_path = Path.join(__DIR__, "reminders.json")
    File.read!(rem_path) |> JSON.decode!(keys: :atoms)
  end

  defp get_rem(rems, today) do
    rems |> Enum.filter(fn x ->
      x.num_days < today + x.offset and x.num_days >= today end)
      |> Enum.map(fn y -> y.day <> " " <> y.month <> " " <> y.message end)
      |> Enum.sort |> Enum.join("\n")
  end

  defp format_text() do
  end

  defp rem_date(date) do
    dt = {year, month, day} = date |> parse_date
    if dt |> greg_date < greg_date, do: yr = year + 1, else: yr = year
    greg = {yr, month, day} |> greg_date
    month_names = %{1 => "Jan", 2 => "Feb", 3 => "Mar", 4 => "Apr", 5 => "May", 6 => "Jun",
    7 => "Jul", 8 => "Aug", 9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dec"}
    mn = month_names[month]
    {yr, mn, to_string(day), greg}
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
