# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def login_required
    return if current_user

    respond_to do |format|
      format.html do
        redirect_to(login_path, alert: t("login_required"))
      end
      format.js { render "shared/_login_required.js.erb", status: :unauthorized }
    end
  end

  def user_not_authorized
    respond_to do |format|
      format.html { redirect_to(root_path, alert: t("unauthorized")) }
      format.js { render "shared/_user_not_authorized.js.erb" }
    end
  end
end
