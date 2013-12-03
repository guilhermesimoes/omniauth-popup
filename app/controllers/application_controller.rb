class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  helper_method :current_user, :authenticate_user!

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale]
    # current_user.locale
    # request.env["HTTP_ACCEPT_LANGUAGE"]
    # request.remote_ip
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

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
