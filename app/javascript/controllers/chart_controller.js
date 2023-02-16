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
          labels: ["Mar-2023"],
          datasets: [ {
            label: "Benchmark",
            type: "bar",
            backgroundColor: "#1EDD88",
            data: [this.data.get("myValue0")],
            stack: 1
          }, {
            label: "Scope 1",
            backgroundColor: "#DDFFBC",
            data: [this.data.get("myValue1")],
            stack: 2,
          }, {
            label: "Scope 2",
            backgroundColor: "#FEFFDE",
            data: [this.data.get("myValue2")],
            stack: 2
          }, {
            label: "Scope 3",
            backgroundColor: "#52734D",
            data: [this.data.get("myValue3")],
            stack: 2
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

    new Chart(
      document.getElementById('footprint_target'),
      {
        type: "bar",
        data: {
          labels: ["2030", "2040", "2050"],
          datasets: [ {
            label: "Objectif intermédiaire 2030",
            backgroundColor: "#FFD3B4",
            data: [this.data.get("myValue4"), "0", "0"],
            stack: 1
          }, {
            label: "Objectif intermédiaire 2040",
            backgroundColor: "#FFD3B4",
            data: ["0", this.data.get("myValue5"), "0"],
            stack: 1
          }, {
            label: "Objectif 2050 approuvé SBTi",
            backgroundColor: "#FFD3B4",
            data: ["0", "0", this.data.get("myValue6")],
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
