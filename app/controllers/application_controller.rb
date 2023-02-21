class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :redirect_users_without_company, if: :user_signed_in?

  def current_company
    return nil unless user_signed_in?
    @company = current_user.company
  end

  def after_sign_in_path_for(resource)
    if current_user.belongs_to_company?
      dashboard_path
    else
      root_path
    end
  end

  private

  def redirect_users_without_company
    # On sort de cette méthode sans meme l'executer si l'utilisateur appartient a une societe
    return if current_user.belongs_to_company?
    return if devise_controller?
    return if current_controller == "companies" && current_action == "new"
    return if current_controller == "companies" && current_action == "create"
    return if current_controller == "pages" && current_action == "home"
    return if current_controller == "companies" && current_action == "index"

    # sinon on le redirige vers la new company
    redirect_to new_company_path, alert: 'Vous devez créer ou rejoindre une société pour accéder à ces fonctionnalités.'
  end

  def current_controller
    params[:controller]
  end

  def current_action
    params[:action]
  end
end
