Yellin::Engine.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  resources :password_resets, only: [:create, :edit, :new, :update]
end
