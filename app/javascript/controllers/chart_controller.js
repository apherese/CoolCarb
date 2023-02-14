import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto';

// Connects to data-controller="chart"
export default class extends Controller {
  // static ELEMENT_ID = 'acquisitions';
  static DEFAULT_OPTIONS = { responsive: true, maintainAspectRatio: false };

  connect() {
    // console.log("coucou from chart controller");
    this.render();
  }

  render() {
    new Chart(
      document.getElementById('footprint'),
      {
        type: "bar",
        data: {
          labels: ["Mar-2023","Jan-2050"],
          datasets: [ {
            label: "Benchmark",
            type: "bar",
            backgroundColor: "#1EDD88",
            data: [this.data.get("myValue0"),"0"],
            stack: 1
          }, {
            label: "Scope 1",
            backgroundColor: "#DDFFBC",
            data: [this.data.get("myValue1"),"0"],
            stack: 3,
          }, {
            label: "Scope 2",
            backgroundColor: "#FEFFDE",
            data: [this.data.get("myValue2"),"0"],
            stack: 3
          }, {
            label: "Scope 3",
            backgroundColor: "#52734D",
            data: [this.data.get("myValue3"),"0"],
            stack: 3
          }, {
            label: "Objectif SBTi",
            backgroundColor: "#98DDCA",
            data: ["0",this.data.get("myValue4")],
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
