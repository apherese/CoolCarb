require "json"

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
    filepath = "data/ademe_data.json"
    data = File.read(filepath)
    list_data = JSON.parse(data)["results"]

    if params[:query].present?
      @compagnies = Company.where(industry: params[:query])
    else
      @compagnies = Company.all
    end

    @companies_with_details = @compagnies.map do |company|
      company_details = list_data.find { |data_set| data_set["Raison_sociale_/_Nom_de_l'entité"] == company.name }
      [company, company_details]
    end
    @companies_with_details = @companies_with_details.select { |_, company_details| company_details }
  end

  private

  def company_params
    params.require(:company).permit(:name, :industry, :employee_nb, :length_of_stay, :load_factor, :room_nb, :admin)
  end
end
