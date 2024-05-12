Yellin::Engine.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  resources :password_resets, only: [:create, :edit, :new, :update]
end
