class SessionsController < ApplicationController
  def create
    # raise env["omniauth.auth"].to_yaml
    omniauth = env['omniauth.auth']
    user = User.find_or_create_with_omniauth(omniauth)
    session[:user_id] = user.id
    flash[:notice] = t('controllers.sessions.create', provider: pretty_name(omniauth.provider))
    render_or_redirect
  end

  def failure
    flash[:alert] = t('controllers.sessions.failure', provider: pretty_name(env['omniauth.error.strategy'].name))
    render_or_redirect
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('controllers.sessions.destroy')
  end

  protected

  def render_or_redirect
    page = env['omniauth.origin']
    if env['omniauth.params']['popup']
      @page = page
      render 'callback', layout: false
    else
      redirect_to page
    end
  end

  def pretty_name(provider_name)
    provider_name.titleize
  end
end
