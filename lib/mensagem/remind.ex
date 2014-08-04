defmodule Mensagem.Remind do
  use Jazz

  alias Mensagem.CLI

  @rem_path Path.join(__DIR__, "reminders.json")
  @months %{1 => "Jan", 2 => "Feb", 3 => "Mar", 4 => "Apr", 5 => "May", 6 => "Jun",
  7 => "Jul", 8 => "Aug", 9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dec"}

  def fetch_remind() do
    rems = get_remfile
    case rems do
      [] -> "No reminders for #{fmt_today}.\n"
      _ -> get_remind(rems, greg_date)
    end
  end

  def add_remind(date, text, diff \\ 0) do
    {year, month, day, greg} = date |> rem_date
    File.write!(@rem_path, Enum.into(get_remfile,
      [%{year: year, month: month, day: day, offset: diff, num_days: greg, message: text}])
      |> Enum.filter(&(&1.num_days >= greg_date)) |> JSON.encode!)
  end

  defp get_remfile() do
    File.read!(@rem_path) |> JSON.decode!(keys: :atoms)
  end

  defp get_remind(rems, today) do
    rem_message = rems
      |> Enum.filter(&(&1.num_days <= today + &1.offset and &1.num_days >= today))
      |> Enum.map(&(&1.day <> " " <> &1.month <> ": " <> &1.message))
      |> Enum.sort |> Enum.join("\n")
    case rem_message do
      "" -> "No reminders for #{fmt_today}.\n"
      _ -> "Reminders for #{fmt_today}.\n" <> rem_message
    end
  end

  defp rem_date(date) do
    dt = {year, month_num, day} = date |> parse_date
    if dt |> greg_date < greg_date, do: year = year + 1
    greg = {year, month_num, day} |> greg_date
    {year, @months[month_num], to_string(day), greg}
  end

  defp parse_date(date) do
    {this_year, _, _} = :erlang.date
    case date |> String.split("/") do
      [year, month, day] -> {to_int(year), to_int(month), to_int(day)}
      [month, day] -> {this_year, to_int(month), to_int(day)}
      _ -> CLI.print_usage
    end
  end

  defp greg_date(date \\ :erlang.date), do: date |> :calendar.date_to_gregorian_days

  defp fmt_today() do
    {_, month_num, day} = :erlang.date
    to_string(day) <> " " <> @months[month_num]
  end

  defp to_int(number), do: String.to_integer number

end
