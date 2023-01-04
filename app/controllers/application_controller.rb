class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized
    flash[:notice] = "Unauthorized action!"
    redirect_to(root_url)
  end
end
