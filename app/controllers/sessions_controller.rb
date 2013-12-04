class SessionsController < ApplicationController
  def create
    # raise env["omniauth.auth"].to_yaml
    omniauth = env['omniauth.auth']
    user = User.find_or_create_with_omniauth(omniauth)
    session[:user_id] = user.id
    flash[:notice] = t('controllers.sessions.create', provider: pretty_name(omniauth.provider))
    popup = env['omniauth.params']['popup']
    next_page = session.delete(:origin) || env['omniauth.origin']
    render_or_redirect(next_page, popup)
  end

  def failure
    flash[:alert] = t('controllers.sessions.failure', provider: pretty_name(env['omniauth.error.strategy'].name))
    # We should be using env['omniauth.params']['popup'] but Omniauth fails
    # on failure so we have to add the on_failure hook in the omniauth.rb file
    popup = params[:popup]
    previous_page = params[:origin]
    render_or_redirect(previous_page, popup)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('controllers.sessions.destroy')
  end

  protected

  def render_or_redirect(page, popup)
    if popup
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
