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
    console.log(this.baseValuesValue)
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
    }, 1000);

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
    // if (isNaN(val)) return;
    if (event.params.step === 'buildings') {
      var currentValue = this.calculator.buildings(val)
    } else if (event.params.step === 'gas') {
      var currentValue = this.calculator.gas(val)
    } else if (event.params.step === 'fuel') {
      var currentValue = this.calculator.fuel(val)
    } else if (event.params.step === 'gasoline') {
      var currentValue = this.calculator.gasoline(val)
    } else if (event.params.step === 'diesel') {
      var currentValue = this.calculator.diesel(val)
    } else if (event.params.step === 'electricity') {
      var currentValue = this.calculator.electricity(val)
    } else if (event.params.step === 'clientsFr') {
      var currentValue = this.calculator.clientsFr(val)
    } else if (event.params.step === 'clientsInt') {
      var currentValue = this.calculator.clientsInt(val)
    } else if (event.params.step === 'suppliers') {
      var currentValue = this.calculator.suppliers(val)
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
