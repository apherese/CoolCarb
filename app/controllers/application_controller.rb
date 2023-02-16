class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_company
    return nil unless user_signed_in?
    @company = current_user.company
  end

  def after_sign_in_path_for(resource)
    if current_user.company != nil
      "/dashboard"
    else
      "/companies/new"
    end
  end
end
