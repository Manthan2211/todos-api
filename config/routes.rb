Rails.application.routes.draw do
 
 root 'todos#index'
 scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :todos, only: :index
  end 
scope module: :v1, constraints: ApiVersion.new('v1', true) do
  resources :todos do
    resources :items
  end
end
  resources :users do
    collection do
      post 'login'
    end
  end
   post '/signup', to: 'users#create'
   post 'auth/login', to: 'authentication#authenticate'
end
