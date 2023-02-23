class CompaniesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.load_factor = @company.load_factor.fdiv(100)
    if @company.save
      current_user.update(admin: true, company_id: @company.id)
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    if params[:query].present?
      @companies = Company.where(industry: params[:query])
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :industry, :employee_nb, :length_of_stay, :load_factor, :room_nb, :admin)
  end
end
