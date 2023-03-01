class PagesController < ApplicationController
  include Charts
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :compute_benchmark_per_employee, only: %i[dashboard targets mon_bilan_carbone]
  before_action :set_footprint, only: %i[dashboard targets mon_bilan_carbone]
  before_action :check_footprint, only: %i[mon_bilan_carbone targets]
  before_action :compute_company_ghg_result, only: %i[dashboard]
  before_action :compute_company_ghg_result_per_employee, only: %i[dashboard]


  def home
  end

  def dashboard
    @company = current_company
  end

  def mon_bilan_carbone
    @company = current_company
  end

  def targets
    @company = current_company
    @task = Task.new
  end

  private

  def check_footprint
    redirect_to new_company_footprint_path(current_company) if @footprint.nil?
  end

  def set_footprint
    @footprint = current_company.footprints.last
  end

  def compute_benchmark_per_employee
    @footprint_benchmark_per_employee = 0
    companies = Company.sector(current_company.industry)
    @company_benchmark_size = companies.size
    @footprint_benchmark_per_employee = companies.sum do |company|
      if company.footprints.where(certified: true).size != 0
        company_ghg_result = company.footprints.where(certified: true).pluck(:ghg_result).sum.fdiv(company.footprints.where(certified: true).size )
        company_ghg_result_per_employee = company_ghg_result.fdiv(company.employee_nb)
        if company_ghg_result_per_employee < EmissionBenchmark::HOTEL_MAX_EMISSION_BENCH
          company_ghg_result_per_employee
        else
          @company_benchmark_size = @company_benchmark_size - 1
          0
        end
      else
        @company_benchmark_size = @company_benchmark_size - 1
        0
      end
    end
    @footprint_benchmark_per_employee = @footprint_benchmark_per_employee.fdiv(@company_benchmark_size)
  end

  def compute_company_ghg_result
    @footprint = @company.footprints.last
    @company_ghg_result = 0
    if @footprint != nil?
      @company_ghg_result = @footprint.ghg_result.round
    end
  end

  def compute_company_ghg_result_per_employee
    @footprint = @company.footprints.last
    @company_ghg_result_per_employee = 0
    if @footprint != nil?
      @company_ghg_result_per_employee = @footprint.ghg_result.fdiv(@company.employee_nb).round
    end
  end
end
