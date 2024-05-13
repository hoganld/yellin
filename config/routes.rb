Yellin::Engine.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  resource :password_reset, only: [:new, :edit, :create, :update]
end
