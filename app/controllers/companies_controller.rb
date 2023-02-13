class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @companies = Company.all
  end

  private

  def company_params
    params.require(:company).permit(:name, :industry, :employee_nb, :admin)
  end
end
