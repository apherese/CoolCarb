import { Controller } from "@hotwired/stimulus"
import { Chart } from 'chart.js/auto';

// Connects to data-controller="chart"
export default class extends Controller {
  connect() {
    console.log("coucou from js contraller chart")
  }
}
