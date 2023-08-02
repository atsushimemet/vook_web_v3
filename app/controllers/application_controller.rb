class ApplicationController < ActionController::Base
  helper_method :current_user, :login?, :admin_login?

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found if Rails.env.production?

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

  def render_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found', layout: 'layouts/application', status: :not_found }
      format.all { render nothing: true, status: :not_found }
    end
  end
end
