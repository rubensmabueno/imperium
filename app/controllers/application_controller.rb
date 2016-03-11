class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :client

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def client
    @client ||= Octokit::Client.new(access_token: current_user.token)
  end
end
