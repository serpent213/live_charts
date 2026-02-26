import * as echarts from 'echarts';

const EChartsHook = {
  mounted() {
    this.renderChart();
    this.handleEvent(`live-charts:update:${this.el.id}`, this.onChartUpdateEvent.bind(this));

    this.resizeHandler = this.onResize.bind(this);
    window.addEventListener('resize', this.resizeHandler);
  },

  updated() {
    this.renderChart();
  },

  destroyed() {
    window.removeEventListener('resize', this.resizeHandler);

    if (this.chart) {
      this.chart.dispose();
      this.chart = null;
    }
  },

  getConfig() {
    const encodedConfig = this.el.dataset.chart;

    if (!encodedConfig) {
      return null;
    }

    delete this.el.dataset.chart;
    return JSON.parse(encodedConfig);
  },

  renderChart() {
    const config = this.getConfig();

    if (!config) {
      return;
    }

    if (this.chart) {
      this.chart.dispose();
    }

    this.chart = echarts.init(this.el);
    this.chart.setOption(config);
  },

  onChartUpdateEvent({ data }) {
    if (!this.chart) {
      return;
    }

    this.chart.setOption({ series: data });
  },

  onResize() {
    if (this.chart) {
      this.chart.resize();
    }
  },
};

export default EChartsHook;
