class EmissionFactors
  GAZ           = 0.2429
  BATIMENTS     = 0.011
  ELECTRICITE   = 0.06
  FIOUL         = 2.68
  ESSENCE       = 2.28
  GAZOLE        = 2.51
  CLIENTFR      = 2.4
  CLIENTINT     = 0.38
  FOURNISSEURS  = 2.51

  class << self
    def to_json
      constants.map do |e|
        [to_json_en(e), const_get(e)]
      end
      .to_h
      .to_json
    end

    def to_json_en(const_name)
      case const_name
      when :GAZ           then 'gasVal'
      when :BATIMENTS     then 'buildingsVal'
      when :ELECTRICITE   then 'electricityVal'
      when :FIOUL         then 'fuelVal'
      when :ESSENCE       then 'gasolineVal'
      when :GAZOLE        then 'dieselVal'
      when :CLIENTFR      then 'clientsFrVal'
      when :CLIENTINT     then 'clientsIntVal'
      when :FOURNISSEURS  then 'suppliersVal'
      end
    end
  end
end
