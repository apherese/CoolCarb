class FootprintsController < ApplicationController
  before_action :set_company, only: %i[new create]

  def new
    @company = Company.find(params[:company_id])
    @footprint = Footprint.new
  end

  def create
    @footprint = Footprint.new(footprint_params)
    @footprint.company = @company
    if @footprint.save
      redirect_to company_path(@company)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def download
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def footprint_params
    params.require(:foorprint).permit(:certified)
  end
end
