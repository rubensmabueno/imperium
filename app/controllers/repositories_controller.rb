class RepositoriesController < ApplicationController
  def select
    session[:repository_name] = params[:name]

    redirect_to root_path
  end
end
