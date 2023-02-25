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
    FootprintCalculation.new(@company, @footprint).calculate
    @footprint.company = @company
    if @footprint.save
      redirect_to mon_bilan_carbone_path
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
