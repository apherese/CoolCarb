class FootprintsController < ApplicationController
  before_action :set_company, only: %i[new create]

  def index
    @footprints = current_company.footprints
  end

  def new
    @footprint = Footprint.new
  end

  def create
    @footprint = Footprint.new(footprint_params)
    gaz_result = (@footprint.gaz * EmissionFactors::GAZ) / 1000
    fioul_result = (@footprint.fioul * EmissionFactors::FIOUL) / 1000
    essence_result = (@footprint.essence * EmissionFactors::ESSENCE) / 1000
    gazole_result = (@footprint.gazole * EmissionFactors::GAZOLE) / 1000
    electricite_result = (@footprint.electricite * EmissionFactors::ELECTRICITE) / 1000
    clients_fr_result = (@footprint.clients_fr * EmissionFactors::CLIENTFR * 500) / 1000
    clients_int_result = (@footprint.clients_int * EmissionFactors::CLIENTINT * 5000) / 1000
    fournisseurs_result = (@footprint.fournisseurs * EmissionFactors::FOURNISSEURS) / 1000
    taille_batiments_results = (@footprint.taille_batiments * EmissionFactors::BATIMENTS) / 1000
    @footprint.scope_1 = (gaz_result + fioul_result + essence_result + gazole_result).round(0)
    @footprint.scope_2 = electricite_result.round(0)
    @footprint.scope_3 = (clients_fr_result + clients_int_result + fournisseurs_result + taille_batiments_results).round(0)
    @footprint.ghg_result = (@footprint.scope_1 + @footprint.scope_2 + @footprint.scope_3).round(0)
    @footprint.ghg_target = (@footprint.ghg_result * 0.12).round(0)
    @footprint.company = @company
    if @footprint.save
      puts "tototot"
      redirect_to footprint_path(@footprint)
    else
      puts "test"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @footprint = Footprint.find(params[:id])
    @company = @footprint.company
  end

  def download
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def footprint_params
    params.require(:footprint).permit(:certified, :gaz, :fioul, :essence, :gazole, :electricite, :clients_fr, :clients_int, :fournisseurs, :taille_batiments)
  end

end
