defmodule DkexplorerWeb.LayoutView do
  use DkexplorerWeb, :view

  def title do
    %{body: body} = HTTPotion.get(
        "http://www.passwordrandom.com/query?command=password"
    )
    body
  end

  defp p_full_sentience do
    1522641600
  end

  def full_sentience do
    p_full_sentience()
  end

  def is_past_full_sentience? do
    (DateTime.utc_now |> DateTime.to_unix) >= p_full_sentience()
  end

  def sentience do
    af_start = 1522555200
    af_end = p_full_sentience()
    time_diff = af_end - af_start
    divisor = time_diff / 100
    current_date = DateTime.utc_now |> DateTime.to_unix
    percent = (current_date - af_start) / divisor
    percent = :math.exp(0.046*percent)
    if percent > 100, do: 100.0, else: percent |> Float.round(2)
  end

  def get_info do
    Dkexplorer.Info.Query.get_last_entry
  end

  def get_blocks do
    Dkexplorer.Block.Query.get_last_five
  end

  def get_image(template) do
      case template do
          "monika" -> "https://i.imgur.com/BHh9aUb.png"
          "natsuki" -> "https://i.imgur.com/L3UcCC2.png"
          "sayori" -> "https://i.imgur.com/97IMzRJ.png"
          "yuri" -> "https://i.imgur.com/HWsKl5s.png"
          _ -> ""
      end
  end
end
