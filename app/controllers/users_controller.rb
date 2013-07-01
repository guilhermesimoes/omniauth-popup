class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def destroy
    @user = User.find(params[:id])
    session[:user_id] = nil if session[:user_id] == @user.id
    @user.destroy
    redirect_to root_url, notice: t('controllers.users.destroy.notice')
  end
end
