class FootprintCalculation
  attr_reader :company, :footprint

  def initialize(company, footprint)
    @company = company
    @footprint = footprint
  end

  def calculate
    @groups = 365 * @company.room_nb * @company.load_factor.fdiv(@company.length_of_stay)
    taille_batiments_results = (@footprint.taille_batiments * EmissionFactors::BATIMENTS)
    gaz_result = (@footprint.gaz * EmissionFactors::GAZ)
    fioul_result = (@footprint.fioul * EmissionFactors::FIOUL)
    essence_result = (@footprint.essence * 1.4 * EmissionFactors::ESSENCE)
    gazole_result = (@footprint.gazole * 1.2 * EmissionFactors::GAZOLE)
    electricite_result = (@footprint.electricite * EmissionFactors::ELECTRICITE)
    clients_fr_result = (@footprint.clients_fr.fdiv(100) * EmissionFactors::CLIENTFR * 0.0021 * @groups)
    clients_int_result = (@footprint.clients_int.fdiv(100) * EmissionFactors::CLIENTINT * @groups)
    fournisseurs_result = (@footprint.fournisseurs * 1.2 * EmissionFactors::FOURNISSEURS)
    @footprint.scope_1 = (gaz_result + fioul_result + essence_result + gazole_result).round
    @footprint.scope_2 = electricite_result.round
    @footprint.scope_3 = (clients_fr_result + clients_int_result + fournisseurs_result + taille_batiments_results).round
    @footprint.ghg_result = (@footprint.scope_1 + @footprint.scope_2 + @footprint.scope_3).round
    @footprint.ghg_target = (@footprint.ghg_result * 0.12).round
    @footprint
  end

end
