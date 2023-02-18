class FootprintsController < ApplicationController
  include Charts
  before_action :set_company, only: %i[new create]
  before_action :compute_benchmark, only: %i[new create show]
  before_action :compute_benchmark_per_employee, only: %i[new create show]

  def index
    @footprints = current_company.footprints
  end

  def new
    @footprint = Footprint.new
  end

  def create
    @footprint = Footprint.new(footprint_params)
    @groups = 365 * @company.room_nb * @company.load_factor.fdiv(@company.length_of_stay)
    gaz_result = (@footprint.gaz * EmissionFactors::GAZ)
    fioul_result = (@footprint.fioul * EmissionFactors::FIOUL)
    essence_result = (@footprint.essence * EmissionFactors::ESSENCE)
    gazole_result = (@footprint.gazole * EmissionFactors::GAZOLE)
    electricite_result = (@footprint.electricite * EmissionFactors::ELECTRICITE)
    clients_fr_result = (@footprint.clients_fr.fdiv(100) * EmissionFactors::CLIENTFR * 0.0021 * @groups)
    clients_int_result = (@footprint.clients_int.fdiv(100) * EmissionFactors::CLIENTINT * @groups)
    fournisseurs_result = (@footprint.fournisseurs * EmissionFactors::FOURNISSEURS)
    taille_batiments_results = (@footprint.taille_batiments * EmissionFactors::BATIMENTS)
    @footprint.scope_1 = (gaz_result + fioul_result + essence_result + gazole_result).round
    @footprint.scope_2 = electricite_result.round
    @footprint.scope_3 = (clients_fr_result + clients_int_result + fournisseurs_result + taille_batiments_results).round
    @footprint.ghg_result = (@footprint.scope_1 + @footprint.scope_2 + @footprint.scope_3).round
    @footprint.ghg_target = (@footprint.ghg_result * 0.12).round
    @footprint.company = @company
    if @footprint.save
      redirect_to footprint_path(@footprint)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.new
    @footprint = Footprint.find(params[:id])
    @company = @footprint.company
    @tasks = @footprint.tasks
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

  def compute_benchmark
    @footprint_benchmark = 0
    companies = Company.sector(current_company.industry)
    @footprint_benchmark = companies.sum do |company|
      if company.footprints.where(certified: true).size != 0
        company.footprints.where(certified: true).pluck(:ghg_result).sum.fdiv(company.footprints.where(certified: true).size)
      else
        0
      end
    end
    @footprint_benchmark = @footprint_benchmark.fdiv(companies.size)
  end
end
