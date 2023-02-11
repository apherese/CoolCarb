class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
  end

  def list
    p "=== TOTO"
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to company_path(@company)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    require "json"
    require "open-uri"
    url = "https://data.ademe.fr/data-fair/api/v1/datasets/bilans-ges/lines?select=Raison_sociale_%2F_Nom_de_l'entit%C3%A9%2CAnn%C3%A9e_de_reporting%2CNombre_de_salari%C3%A9s_%2F_d'agents%2CAPE(NAF)%2CEmissions_publication_P1_-_tCO2e%2CEmissions_publication_P2_-_tCO2e%2CEmissions_publication_P3_-_tCO2e%2CEmissions_publication_P4_-_tCO2e%2CEmissions_publication_P5_-_tCO2e%2CEmissions_publication_P6_-_tCO2e%2CEmissions_publication_P7_-_tCO2e%2CEmissions_publication_P8_-_tCO2e%2CEmissions_publication_P9_-_tCO2e%2CEmissions_publication_P10_-_tCO2e%2CEmissions_publication_P11_-_tCO2e%2CEmissions_publication_P12_-_tCO2e%2CEmissions_publication_P13_-_tCO2e%2CEmissions_publication_P14_-_tCO2e%2CEmissions_publication_P15_-_tCO2e%2CEmissions_publication_P16_-_tCO2e%2CEmissions_publication_P17_-_tCO2e%2CEmissions_publication_P18_-_tCO2e%2CEmissions_publication_P19_-_tCO2e%2CEmissions_publication_P20_-_tCO2e%2CEmissions_publication_P21_-_tCO2e%2CEmissions_publication_P22_-_tCO2e%2CEmissions_publication_P23_-_tCO2e%2CVolume_de_r%C3%A9duction_attendu_-_Scope_1_-_en_tCO2e%2CVolume_de_r%C3%A9duction_attendu_-_Scope_2_-_en_tCO2e%2CVolume_de_r%C3%A9duction_attendu_-_Scope_3_-_en_tCO2e%2CPlan_d'actions_-_Scope_1%2CPlan_d'actions_-_Scope_2%2CPlan_d'actions_-_Scope_3&qs=5510Z"
    list_hotel_serialized = URI.open(url).read
    @list_hotel = JSON.parse(list_hotel_serialized)
  end

  private

  def company_params
    params.require(:company).permit(:name, :industry, :employee_nb, :kwh, :square_meter, :admin)
  end
end
