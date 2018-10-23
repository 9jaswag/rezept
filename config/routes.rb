Rails.application.routes.draw do
  namespace :v1 do
    resources :recipis, except: %i[destroy update] do
      delete '/user/:id' => 'recipes#destroy', as: 'delete'
      patch '/user/:id' => 'recipes#update', as: 'update'
    end
  end
  post '/signup', to: 'users#create'
  get '/activate/:token', to: 'users#edit', as: 'activate'
  patch '/reset/:token', to: 'users#update', as: 'reset'
  post '/password_reset', to: 'users#reset'
  post '/login', to: 'users#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
