class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :authenticate_user!

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    if !current_user
      session[:origin] = request.fullpath
      redirect_to '/auth/twitter'
    end
  end
end
