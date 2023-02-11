class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_company
    return nil unless user_signed_in?
    current_user.company
  end
end
