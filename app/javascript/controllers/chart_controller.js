import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto';

// Connects to data-controller="chart"
export default class extends Controller {
  // static ELEMENT_ID = 'acquisitions';
  static DEFAULT_OPTIONS = { responsive: true, maintainAspectRatio: false };

  connect() {
    console.log("coucou from chart controller");
    this.render();
  }

  render() {

    new Chart(
      document.getElementById('acquisitions'),
      {
        type: "bar",
        data: {
          labels: ["Mar-2016","Apr-2016"],
          datasets: [ {
            label: "Crossville",
            backgroundColor: "#009900",
            data: ["2268.44","2268"],
            stack: 2,
          }, {
            label: "test",
            backgroundColor: "#ffff00",
            data: ["181.92","181.92"],
            stack: 2
          },{
            label: "benchmark",
            type: "bar",
            backgroundColor: "#ff3300",
            data: ["2632.29","2632.29"],
            stack: 1
          }]
        },
        options: {
          scales: {
            yAxes: [{
              id: "stacked_testY",
              type: 'linear',
              position: "left",
              stacked: true,
              display: true
            }],
            xAxes: [{
              position: "bottom",
              stacked: true,
              display: true
            }]
          }
        }
      }
    );
  };
}
