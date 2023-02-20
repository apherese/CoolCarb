import { Controller } from "@hotwired/stimulus"
import { start } from "@popperjs/core";
import Chart from 'chart.js/auto';

// Connects to data-controller="chart"
export default class extends Controller {
  // static ELEMENT_ID = 'acquisitions';
  static DEFAULT_OPTIONS = { responsive: true, maintainAspectRatio: false };

  connect() {
    this.render();
  }

  render() {
    const benchmarkCanva = document.querySelector('canvas#benchmark')
    const footprintCanva = document.querySelector('canvas#footprint')
    const tasksCanva = document.querySelector('canvas#tasks')
    Chart.defaults.font.size = 28;

    if (benchmarkCanva) {
      new Chart(
        benchmarkCanva,
        {
          type: "bar",
          data: {
            labels: ["Les meilleurs de votre secteur"],
            datasets: [ {
              label: "Benchmark",
              type: "bar",
              backgroundColor: "#1EDD88",
              data: [this.data.get("myValue0")],
              stack: 1
            }]
          },
          options: {
            plugins: {
                title: {
                display: true,
                align: "start",
                color: "#1D4728",
                text: 'Tonnes de CO2/collaborateur',
                padding: {
                  top: 10,
                  bottom: 40
                },
              },
              legend: {
                  display: false,
                  position: 'bottom',
                  labels: {
                    // This more specific font property overrides the global property
                    font: {
                        size: 18
                    },
                  },
              },
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
        }
      );
    }

    if (footprintCanva) {
      new Chart(
        footprintCanva,
        {
          type: "bar",
          data: {
            labels: ["Benchmark - Bilan - Objectifs 2030-40-50"],
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
            }, {
              label: "Objectif intermédiaire 2030",
              backgroundColor: "#FFD3B4",
              data: [this.data.get("myValue4")],
              stack: 4
            }, {
              label: "Objectif intermédiaire 2040",
              backgroundColor: "#FFD3B4",
              data: [this.data.get("myValue5")],
              stack: 5
            }, {
              label: "Objectif 2050 approuvé SBTi",
              backgroundColor: "#FFD3B4",
              data: [this.data.get("myValue6")],
              stack: 6
            }]
          },
          options: {
            plugins: {
              title: {
              display: true,
              align: "start",
              color: "#1D4728",
              text: 'Tonnes de CO2/collaborateur',
              padding: {
                top: 10,
                bottom: 40
              },
            },
              legend: {
                  display: false,
                  position: 'bottom',
                  labels: {
                    // This more specific font property overrides the global property
                    font: {
                        size: 18
                    },
                  },
              },
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
        }
      );
    }

    if (tasksCanva) {
      new Chart(
        tasksCanva,
        {
          type: "bar",
          data: {
            labels: ["Benchmark - Bilan - Bilan après actions - Objectifs 2030-40-50"],
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
            }, {
              label: "Bilan APRES le plan d'action",
              backgroundColor: "#98DDCA",
              data: [this.data.get("myValue7")],
              stack: 3
            }, {
              label: "Objectif intermédiaire 2030",
              backgroundColor: "#FFD3B4",
              data: [this.data.get("myValue4")],
              stack: 4
            }, {
              label: "Objectif intermédiaire 2040",
              backgroundColor: "#FFD3B4",
              data: [this.data.get("myValue5")],
              stack: 5
            }, {
              label: "Objectif 2050 approuvé SBTi",
              backgroundColor: "#FFD3B4",
              data: [this.data.get("myValue6")],
              stack: 6
            }]
          },
          options: {
            plugins: {
              title: {
              display: true,
              align: "start",
              color: "#1D4728",
              text: 'Tonnes de CO2/collaborateur',
              padding: {
                top: 10,
                bottom: 40
              },
            },
              legend: {
                  display: false,
                  position: 'bottom',
                  labels: {
                    // This more specific font property overrides the global property
                    font: {
                        size: 18
                    },
                  },
              },
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
        }
      );
    }





    // new Chart(
    //   document.getElementById('footprint_target'),
    //   {
    //     type: "bar",
    //     data: {
    //       labels: ["2030", "2040", "2050"],
    //       datasets: [ {
    //         label: "Objectif intermédiaire 2030",
    //         backgroundColor: "#FFD3B4",
    //         data: [this.data.get("myValue4"), "0", "0"],
    //         stack: 1
    //       }, {
    //         label: "Objectif intermédiaire 2040",
    //         backgroundColor: "#FFD3B4",
    //         data: ["0", this.data.get("myValue5"), "0"],
    //         stack: 1
    //       }, {
    //         label: "Objectif 2050 approuvé SBTi",
    //         backgroundColor: "#FFD3B4",
    //         data: ["0", "0", this.data.get("myValue6")],
    //         stack: 1
    //       }]
    //     },
    //     options: {
    //       scales: {
    //         yAxes: [{
    //           id: "stacked_testY",
    //           type: 'linear',
    //           position: "left",
    //           stacked: true,
    //           display: true
    //         }],
    //         xAxes: [{
    //           position: "bottom",
    //           stacked: true,
    //           display: true
    //         }]
    //       }
    //     }
    //   }
    // );

    // new Chart(
    //   document.getElementById('tasks'),
    //   {
    //     type: "bar",
    //     data: {
    //       labels: ["2013-2020"],
    //       datasets: [ {
    //         label: "Isoler les bâtiments",
    //         backgroundColor: "#98DDCA",
    //         data: [this.data.get("myValue7")],
    //         stack: 1
    //       }]
    //     },
    //     options: {
    //       scales: {
    //         yAxes: [{
    //           id: "stacked_testY",
    //           type: 'linear',
    //           position: "left",
    //           stacked: true,
    //           display: true
    //         }],
    //         xAxes: [{
    //           position: "bottom",
    //           stacked: true,
    //           display: true
    //         }]
    //       }
    //     }
    //   }
    // );
  };
}
