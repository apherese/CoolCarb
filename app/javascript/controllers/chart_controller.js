import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto';

// Connects to data-controller="chart"
export default class extends Controller {
  static ELEMENT_ID = 'YOUR_ELEMENT_ID';
  static DEFAULT_OPTIONS = { responsive: true, maintainAspectRatio: false };

  connect() {
    this.render();
  }

  render() {
    if (!this.ele) return;

    const ctx = this.ele.getContext('2d');

    this.graph = new Chart(ctx, { type: 'line', data: this.data, options: this.options });
  }

  get ele() {
    return this._ele = this._ele || document.getElementById(ChartController.ELEMENT_ID);
  }

  get metric() {
    return this._metric = this._metric || this.element.dataset.metric;
  }

  get unit() {
    return this._unit = this._unit || this.element.dataset.unit;
  }

  get metrics() {
    return this._metrics = this._metrics || JSON.parse(document.querySelector('[data-metrics-type]').dataset.metrics);
  }

  get options() {
    return ChartController.DEFAULT_OPTIONS;
  }

  get data() {
    return { labels: this.labels, datasets: this.datasets };
  }

  get labels() {
    return this._labels = this._labels || this.metrics.map((m) => new Date(m.updated_at).toDateString());
  }

  get datasets() {
    return [{
      label: `${this.metric} / ${this.unit}`,
      data: this.metrics.map((m) => parseInt(m.value, 10)),
      fill: false,
      borderColor: 'rgb(75, 192, 192)',
      tension: 0.1
    }];
  }
}
