class ApplicationController < ActionController::Base
  helper_method :current_user, :login?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logout
    session.delete(:user_id)
  end

  def login?
    current_user.present?
  end

  def require_admin_login
    return if current_user&.admin?

    redirect_to root_path, alert: '管理者としてログインしてください'
  end
end
