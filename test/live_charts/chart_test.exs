defmodule LiveCharts.ChartTest do
  use ExUnit.Case, async: true

  alias LiveCharts.Chart

  test "build/1 keeps hook options empty by default" do
    chart = Chart.build(%{type: :line})

    assert chart.hook_options == %{}
  end

  test "build/2 maps echarts_init to hook options for echarts adapter" do
    chart =
      Chart.build(
        %{
          type: :line,
          adapter: LiveCharts.Adapter.ECharts
        },
        echarts_init: %{renderer: :svg, useDirtyRect: true}
      )

    assert chart.hook_options == %{init: %{renderer: :svg, useDirtyRect: true}}
  end

  test "build/2 ignores echarts_init for non-echarts adapters" do
    chart =
      Chart.build(
        %{
          type: :line,
          adapter: LiveCharts.Adapter.ApexCharts
        },
        echarts_init: %{renderer: :svg}
      )

    assert chart.hook_options == %{}
  end

  test "build/2 keeps echarts_init renderer values unchanged" do
    chart =
      Chart.build(
        %{
          type: :line,
          adapter: LiveCharts.Adapter.ECharts
        },
        echarts_init: %{renderer: :webgl}
      )

    assert chart.hook_options == %{init: %{renderer: :webgl}}
  end
end
