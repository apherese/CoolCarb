export class FootprintCalculator {
  constructor(company, baseValues) {
    this.gasVal             = baseValues.gasVal
    this.buildingsVal       = baseValues.buildingsVal
    this.electricityVal     = baseValues.electricityVal
    this.fuelVal            = baseValues.fuelVal
    this.gasolineVal        = baseValues.gasolineVal
    this.dieselVal          = baseValues.dieselVal
    this.clientsFrVal       = baseValues.clientsFrVal
    this.clientsIntVal      = baseValues.clientsIntVal
    this.suppliersVal       = baseValues.suppliersVal
    this.groups             = 365 * company.room_nb * (company.load_factor / company.length_of_stay)
    this.gasResult          = 0
    this.fuelResult         = 0
    this.gasolineResult     = 0
    this.dieselResult       = 0
    this.electricityResult  = 0
    this.clientsFrResult    = 0
    this.clientsIntResult   = 0
    this.suppliersResult    = 0
    this.buildingsResult    = 0
  }

  gas(val) {
    return this.gasResult = this.#roundToDecimal(val * this.gasVal, 2)
  }

  fuel(val) {
    return this.fuelResult = this.#roundToDecimal(val * this.fuelVal, 2)
  }

  buildings(val) {
    return this.buildingsResult = this.#roundToDecimal(val * this.buildingsVal, 2)
  }

  gasoline(val) {
    return this.gasolineResult = this.#roundToDecimal(val * 1.4 * this.gasolineVal, 2)
  }

  diesel(val) {
    return this.dieselResult = this.#roundToDecimal(val * 1.2 * this.dieselVal, 2)
  }

  electricity(val) {
    return this.electricityResult = this.#roundToDecimal(val * this.electricityVal, 2)
  }

  clientsFr(val) {
    return this.clientsFrResult = this.#roundToDecimal((val / 100) * this.clientsFrVal * 0.0021 * this.groups, 2)
  }

  clientsInt(val) {
    return this.clientsIntResult = this.#roundToDecimal((val / 100) * this.clientsIntVal * this.groups, 2)
  }

  suppliers(val) {
    return this.suppliersResult = this.#roundToDecimal(val * 0.01 * this.suppliersVal, 2)
  }

  #buildingsSize() {
    return this.result = this.#roundToDecimal(gas * this.buildingsVal, 2)
  }

  scope1() {
    return this.#roundToDecimal(this.gasResult + this.fuelResult + this.gasolineResult + this.dieselResult, 2)
  }

  scope2() {
    return this.#roundToDecimal(this.electricityResult, 2)
  }

  scope3() {
    return this.#roundToDecimal(this.clientsFrResult + this.clientsIntResult + this.suppliersResult + this.buildingsResult, 2)
  }

  result() {
    return this.#roundToDecimal(this.scope1() + this.scope2() + this.scope3(), 2)
  }

  #roundToDecimal(n, decimals = 0) {
    return +(Math.round(n + `e+${decimals}`)  + `e-${decimals}`)
  }
}

global.FootprintCalculator = FootprintCalculator

