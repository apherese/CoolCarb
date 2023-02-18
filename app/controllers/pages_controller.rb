class PagesController < ApplicationController
  include Charts
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :compute_benchmark_per_employee, only: %i[dashboard targets mon_bilan_carbone]
  before_action :set_footprint, only: %i[dashboard targets mon_bilan_carbone]

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
  end

  private

  def set_footprint
    @footprint = current_company.footprints.last
  end


end
