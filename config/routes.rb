Miniauth::Engine.routes.draw do
  get 'signup', to: 'registrations#new'
  post 'signup', to: 'registrations#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:create, :edit, :new, :update]
end
