defmodule LiveCharts.Adapter.ECharts do
  use LiveCharts.Adapter

  @moduledoc """
  LiveCharts adapter for Apache ECharts.

  All ECharts options should be set under the `:options` key in the `%Chart{}`
  config. The `:series` option is always set from `%Chart{series: ...}` and each
  series entry gets a default `:type` based on `%Chart{type: ...}` when missing.
  """

  alias LiveCharts.Chart

  @impl true
  def hook(_chart) do
    "LiveCharts.Hooks.ECharts"
  end

  @impl true
  def hook_opts(%Chart{} = chart), do: chart.hook_options

  @impl true
  def build_config(%Chart{} = chart) do
    options = Map.drop(chart.options, [:series])

    Map.merge(options, %{
      series: normalize_series(chart.series, chart.type)
    })
  end

  defp normalize_series(series, type) when is_list(series) do
    Enum.map(series, &normalize_series_item(&1, type))
  end

  defp normalize_series(_series, type) do
    [%{type: to_string(type), data: []}]
  end

  defp normalize_series_item(series_item, type) when is_map(series_item) do
    Map.put_new(series_item, :type, to_string(type))
  end

  defp normalize_series_item(data, type) do
    %{type: to_string(type), data: data}
  end
end
