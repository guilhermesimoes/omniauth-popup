class SessionsController < ApplicationController
  def create
    # raise env["omniauth.auth"].to_yaml
    omniauth = env['omniauth.auth']
    user = User.find_or_create_with_omniauth(omniauth)
    session[:user_id] = user.id
    flash[:notice] = "Successfully authenticated with #{provider_name(omniauth.provider)}."
    popup = env['omniauth.params']['popup']
    next_page = session.delete(:origin) || env['omniauth.origin']
    render_or_redirect(next_page, popup)
  end

  def failure
    flash[:alert] = "Sorry, you didn't authorize logging in with #{provider_name(params[:strategy])}."
    # We should be using env['omniauth.params']['popup'] but Omniauth fails
    # on failure so we have to add the on_failure hook in the omniauth.rb file
    popup = params[:popup]
    previous_page = params[:origin]
    render_or_redirect(previous_page, popup)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed out!'
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

  def provider_name(provider)
    if provider == 'google_oauth2'
      'Google'
    else
      provider.titleize
    end
  end
end
