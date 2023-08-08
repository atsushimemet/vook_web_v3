class ApplicationController < ActionController::Base
  helper_method :current_user, :login?, :admin_login?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logout
    session.delete(:user_id)
  end

  def login?
    current_user.present?
  end

  def admin_login?
    current_user&.admin?
  end

  def require_admin_login
    return if current_user&.admin?

    redirect_to root_path, alert: '管理者としてログインしてください'
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  if Rails.env.production?
    rescue_from ActionController::RoutingError, with: :render_not_found
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  end

  private

  def render_not_found
    respond_to do |format|
      format.html { render 'errors/not_found', status: :not_found }
    end
  end
end
