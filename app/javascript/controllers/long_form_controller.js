import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="long-form"
export default class extends Controller {
  static targets = ["screen"]
  connect() {
    this.index = 0
  }

  back() {
    if (this.index===0) return
    this.index--
    const screen = this.screenTargets[this.index]
    screen.scrollIntoView({behavior: "smooth"})
  }

  next() {
    this.index++
    const screen = this.screenTargets[this.index]
    screen.scrollIntoView({behavior: "smooth"})
  }
}
