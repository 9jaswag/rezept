Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :recipis
  end
  post '/signup', to: 'users#create'
  get '/activate/:token', to: 'users#edit', as: 'activate'
  patch '/reset/:token', to: 'users#update', as: 'reset'
  post '/password_reset', to: 'users#reset'
  post '/login', to: 'users#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
