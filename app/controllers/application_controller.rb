class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_client, :current_repository

  before_action :redirect_to_login, unless: :current_user

  private

  def redirect_to_login
    redirect_to login_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound => e
    session[:user_id] = nil
    redirect_to login_path
  end

  def current_client
    @current_client ||= Octokit::Client.new(access_token: current_user.token)
  end

  def current_repository
    # return if session[:repository_name].blank?

    @current_repository ||= current_client.repository('toptal/chewy')
  end
end
