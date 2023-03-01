import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="long-form"
export default class extends Controller {
  static targets = [
    "screen",
    "form",
    'ghgResult',
    'currentInputValueResult',
    'scope1Result',
    'scope2Result',
    'scope3Result'
  ]
  static values= {
    company: Object,
    baseValues: Object,
    steps: Array
  }

  connect() {
    this.calculator = new FootprintCalculator(this.companyValue, this.baseValuesValue)
    this.index = 0
    this.#preventSubmitUntilEndReached()
  }

  back() {
    if (this.index === 0) return
    this.index--
    const screen = this.screenTargets[this.index]
    screen.scrollIntoView({behavior: "smooth"})
    setTimeout(() => {
      screen.querySelector("input").focus()
      this.#cleanCurrentValues()
    }, 500);

  }

  next() {
    this.index++
    const screen = this.screenTargets[this.index]
    screen.scrollIntoView({behavior: "smooth"})
    setTimeout(() => {
      screen.querySelector("input").focus()
      this.#cleanCurrentValues()
    }, 500);
  }

  #preventSubmitUntilEndReached() {
    this.formTarget.addEventListener("submit", (event) => {
      if ( this.screenTargets.length === this.index + 1) {
        this.formTarget.submit()
      } else {
        event.preventDefault()
        this.next()
      }
    })
  }

  updateResult(event) {
    const val = event.currentTarget.value
    if (val && !!val.match(/[^\d]/)) return

    switch (event.params.step) {
      case 'buildings':   { var currentValue = this.calculator.buildings(val); break; }
      case 'gas':         { var currentValue = this.calculator.gas(val); break; }
      case 'fuel':        { var currentValue = this.calculator.fuel(val); break; }
      case 'gasoline':    { var currentValue = this.calculator.gasoline(val); break; }
      case 'diesel':      { var currentValue = this.calculator.diesel(val); break; }
      case 'electricity': { var currentValue = this.calculator.electricity(val); break; }
      case 'clientsFr':   { var currentValue = this.calculator.clientsFr(val); break; }
      case 'clientsInt':  { var currentValue = this.calculator.clientsInt(val); break; }
      case 'suppliers':   { var currentValue = this.calculator.suppliers(val); break; }
    }

    this.#updateCurrentValues(currentValue)

    this.ghgResultTarget.innerText = this.calculator.result()
    this.scope1ResultTarget.innerText = this.calculator.scope1()
    this.scope2ResultTarget.innerText = this.calculator.scope2()
    this.scope3ResultTarget.innerText = this.calculator.scope3()
  }

  #cleanCurrentValues() {
    this.currentInputValueResultTargets.forEach(e => e.innerText = "0")
  }

  #updateCurrentValues(val) {
    this.currentInputValueResultTargets.forEach(e => e.innerText = val)
  }
}
