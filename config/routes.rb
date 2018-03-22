Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   resources :todos do
    resources :items
  end
  resources :users do
    collection do
      post 'login'
    end
  end
   post '/signup', to: 'users#create'
end
