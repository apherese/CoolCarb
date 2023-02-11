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
    gaz_result = (@footprint.gaz * 0.1850) / 1000
    fioul_result = (@footprint.fioul * 2.68) / 1000
    essence_result = (@footprint.essence * 2.280) / 1000
    gazole_result = (@footprint.gazole * 2.510) / 1000
    electricite_result = (@footprint.electricite * 0.04) / 1000
    clients_fr_result = (@footprint.clients_fr * 2.4 * 500) / 1000
    clients_int_result = (@footprint.clients_int * 0.19 * 5000) / 1000
    fournisseurs_result = (@footprint.fournisseurs * 2.510) / 1000
    taille_batiments_results = (@footprint.taille_batiments * 11) / 1000
    @footprint.ghg_result = gaz_result + fioul_result + essence_result + gazole_result + electricite_result + clients_fr_result + clients_int_result + fournisseurs_result + taille_batiments_results
    @footprint.company = @company
    if @footprint.save
      redirect_to company_path(@company)
    else
      render :new, status: :unprocessable_entity
    end
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
