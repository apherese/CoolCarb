class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

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
end
