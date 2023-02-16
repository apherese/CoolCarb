class FootprintsController < ApplicationController
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
    gaz_result = (@footprint.gaz * EmissionFactors::GAZ) / 1000
    fioul_result = (@footprint.fioul * EmissionFactors::FIOUL) / 1000
    essence_result = (@footprint.essence * EmissionFactors::ESSENCE) / 1000
    gazole_result = (@footprint.gazole * EmissionFactors::GAZOLE) / 1000
    electricite_result = (@footprint.electricite * EmissionFactors::ELECTRICITE) / 1000
    clients_fr_result = (@footprint.clients_fr * EmissionFactors::CLIENTFR * 500) / 1000
    clients_int_result = (@footprint.clients_int * EmissionFactors::CLIENTINT * 5000) / 1000
    fournisseurs_result = (@footprint.fournisseurs * EmissionFactors::FOURNISSEURS) / 1000
    taille_batiments_results = (@footprint.taille_batiments * EmissionFactors::BATIMENTS) / 1000
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

  def compute_benchmark_per_employee
    @footprint_benchmark_per_employee = 0
    companies = Company.sector(current_company.industry)
    @footprint_benchmark_per_employee = companies.sum do |company|
      if company.footprints.where(certified: true).size != 0
        company.footprints.where(certified: true).pluck(:ghg_result).sum.fdiv(company.footprints.where(certified: true).size * company.employee_nb)
      else
        0
      end
    end
    @footprint_benchmark_per_employee = @footprint_benchmark_per_employee.fdiv(companies.size)
  end
end
