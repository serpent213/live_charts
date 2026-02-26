defmodule LiveCharts.Adapter.EChartsTest do
  use ExUnit.Case, async: true

  alias LiveCharts.Adapter.ECharts
  alias LiveCharts.Chart

  test "hook/1 returns echarts hook name" do
    assert ECharts.hook(%Chart{}) == "LiveCharts.Hooks.ECharts"
  end

  test "build_config/1 merges options and injects default series type" do
    chart = %Chart{
      id: "chart-1",
      type: :line,
      series: [%{name: "Revenue", data: [10, 20, 30]}],
      options: %{xAxis: %{type: "category"}}
    }

    assert ECharts.build_config(chart) == %{
             xAxis: %{type: "category"},
             series: [%{name: "Revenue", type: "line", data: [10, 20, 30]}]
           }
  end

  test "build_config/1 preserves explicit series type and overrides options.series" do
    chart = %Chart{
      id: "chart-2",
      type: :line,
      series: [%{type: "bar", data: [1, 2, 3]}],
      options: %{series: [%{type: "scatter", data: [99]}], yAxis: %{type: "value"}}
    }

    assert ECharts.build_config(chart) == %{
             yAxis: %{type: "value"},
             series: [%{type: "bar", data: [1, 2, 3]}]
           }
  end
end
