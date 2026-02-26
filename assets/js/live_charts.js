import LiveChartsApex from './live_charts.apex';
import LiveChartsECharts from './live_charts.echarts';

export default {
  Hooks: {
    ...LiveChartsApex.Hooks,
    ...LiveChartsECharts.Hooks,
  },
};
