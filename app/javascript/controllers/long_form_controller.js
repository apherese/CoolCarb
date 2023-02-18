import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="long-form"
export default class extends Controller {
  static targets = ["screen", "form"]
  connect() {
    this.index = 0
    this.formTarget.addEventListener("submit", (event) => {
      if ( this.screenTargets.lenght === this.index + 1) {
        this.formTarget.submit()
      } else {
        event.preventDefault()
        this.next()
      }
    })
  }

  back() {
    if (this.index === 0) return
    this.index--
    const screen = this.screenTargets[this.index]
    screen.scrollIntoView({behavior: "smooth"})
    setTimeout(() => {
      screen.querySelector("input").focus()
    }, 500);
  }

  next() {
    this.index++
    const screen = this.screenTargets[this.index]
    screen.scrollIntoView({behavior: "smooth"})
    setTimeout(() => {
      screen.querySelector("input").focus()
    }, 500);
  }
}
