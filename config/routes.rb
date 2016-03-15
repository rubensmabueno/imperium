Rails.application.routes.draw do
  root to: 'home#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout
  get '/login' => 'sessions#new', as: :login

  # Repositories
  get '/repositories/:name/select' => 'repositories#select',
      as: :select_repository

  get 'analytics/issues' => 'analytics#issues', as: :analytics_issues

  scope '/api' do
    scope '/v1' do
      scope '/issues' do
        get '/' => 'api/v1/issues#index'
      end
    end
  end
end
