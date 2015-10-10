Rails.application.routes.draw do
  get '/ping' => 'main#ping'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#auth_failed'

  delete '/sessions/:id' => 'sessions#destroy'

  resources :tags, only: [:create, :update, :destroy], constraints: {format: :json}
  resources :haikus, constraints: {format: :json} 
  resources :users, only: [:index, :create, :update, :show, :destroy], constraints: {format: :json}
  root to: 'haikus#index'
end
