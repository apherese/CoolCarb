import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto';
import ChartDataLabels from 'chartjs-plugin-datalabels';

Chart.register(ChartDataLabels);


// Connects to data-controller="chart"
export default class extends Controller {
  static DEFAULT_OPTIONS = { responsive: true, maintainAspectRatio: false };

  connect() {
    this.render();
  }

  render() {
    console.log("coucou from chart controller!!!!!")
    // const benchmarkCanva = document.querySelector('canvas#benchmark')
    const footprintCanva = document.querySelector('canvas#footprint')
    const tasksCanva = document.querySelector('canvas#tasks')

    Chart.defaults.font.size = 16;
    Chart.defaults.font.color = "#40497E";
    Chart.defaults.font.family = "Quicksand", "sans-serif";
    Chart.defaults.plugins.legend.display = false;
    Chart.defaults.datasets.bar.maxBarThickness = 50;
    Chart.defaults.datasets.bar.maxBarThickness = 50;

    if (footprintCanva) {
      new Chart(
        footprintCanva,
        {
          type: "bar",
          data: {
            labels: ["Benchmark", "Bilan carbone", "Objectif 2030", "Objectif 2040", "Objectif 2050"],
            datasets: [{
              backgroundColor:  "#CCF7BB",
              data: [this.data.get("myValue0"), 0, this.data.get("myValue4"), this.data.get("myValue5"), this.data.get("myValue6") ],
              datalabels: {
                align: 'end',
                anchor: 'start'
              }
            }, {
              label: "Scope 1",
              backgroundColor: "#B2BAEB",
              data: [0, this.data.get("myValue1"), 0, 0, 0],
              datalabels: {
                align: 'center',
                anchor: 'center'
              }
            }, {
              label: "Scope 2",
              backgroundColor: "#778AFB",
              data: [0, this.data.get("myValue2"), 0, 0, 0],
              datalabels: {
                anchor: 'center',
                align: 'center',
              }
            }, {
              label: "Scope 3",
              backgroundColor: "#40497E",
              data: [0, this.data.get("myValue3"), 0, 0, 0],
              datalabels: {
                anchor: 'center',
                align: 'center',
              }
            }
          ]
          },
          options: {
            plugins: {
              title: {
                display: true,
                align: "center",
                color: "#40497E",
                text: 'Vos résultats (tCO2/col.) avant votre plan d\'action',
                font: {
                  size: 35,
                  style: "bold",
                },
                padding: {
                  top: 10,
                  bottom: 40
                },
              },
              datalabels: {
                color: function(context) {
                  return context.dataset.backgroundColor==="#CCF7BB" ? "#40497E" : "#FDFBF6" ;
                },
                display: function(context) {
                  return context.dataset.data[context.dataIndex] > 1;
                },
                font: {
                  weight: 'bold'
                },
                formatter: Math.round
              }
            },

            // Core options
            aspectRatio: 5 / 3,
            layout: {
              padding: {
                top: 24,
                right: 16,
                bottom: 0,
                left: 8
              }
            },
            elements: {
              line: {
                fill: false
              },
              point: {
                hoverRadius: 7,
                radius: 5
              }
            },
            scales: {
              y: {
                display: false,
                stacked: true,
                grid: {
                  display: false
                }
              },
              x: {
                stacked: true,
                grid: {
                  display: false
                }
              },
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
            labels: ["Benchmark", `Bilan carbone (total=${this.data.get("myValue1")+this.data.get("myValue2")+this.data.get("myValue3")})`, `Bilan après actions (${this.data.get("myValue8")})` , "Objectif 2030", "Objectif 2040", "Objectif 2050"],
            datasets: [{
              backgroundColor:  "#CCF7BB",
              data: [this.data.get("myValue0"), 0, 0, this.data.get("myValue4"), this.data.get("myValue5"), this.data.get("myValue6") ],
              datalabels: {
                align: 'end',
                anchor: 'start'
              }
            }, {
              label: "Scope 1",
              backgroundColor: "#B2BAEB",
              data: [0, this.data.get("myValue1"), 0, 0, 0, 0],
              datalabels: {
                align: 'center',
                anchor: 'center'
              }
            }, {
              label: "Scope 2",
              backgroundColor: "#778AFB",
              data: [0, this.data.get("myValue2"), 0, 0, 0, 0],
              datalabels: {
                anchor: 'center',
                align: 'center',
              }
            }, {
              label: "Scope 3",
              backgroundColor: "#40497E",
              data: [0, this.data.get("myValue3"), 0, 0, 0, 0],
              datalabels: {
                anchor: 'center',
                align: 'center',
              }
            }, {
              label: "Scope 1+2+3",
              backgroundColor: "#6070D8",
              data: [0, 0, this.data.get("myValue7"), 0, 0, 0],
              datalabels: {
                anchor: 'end',
                align: 'start',
              }
            }
          ]
          },
          options: {
            plugins: {
              title: {
                display: true,
                align: "center",
                color: "#40497E",
                text: 'Vos résultats (tCO2/col.), avant / après vos actions',
                font: {
                  size: 35,
                  style: "bold",
                },
                padding: {
                  top: 10,
                  bottom: 40
                },
              },
              datalabels: {
                color: function(context) {
                  return context.dataset.backgroundColor==="#CCF7BB" ? "#40497E" : "#FDFBF6" ;
                },
                display: function(context) {
                  return context.dataset.data[context.dataIndex] > 1;
                },
                font: {
                  weight: 'bold'
                },
                formatter: Math.round
              }
            },

            // Core options
            aspectRatio: 5 / 3,
            layout: {
              padding: {
                top: 24,
                right: 16,
                bottom: 0,
                left: 8
              }
            },
            elements: {
              line: {
                fill: false
              },
              point: {
                hoverRadius: 7,
                radius: 5
              }
            },
            scales: {
              y: {
                display: false,
                stacked: true,
                grid: {
                  display: false
                }
              },
              x: {
                stacked: true,
                grid: {
                  display: false
                }
              },
            }
          }
        }
      );
    }
  }
}
