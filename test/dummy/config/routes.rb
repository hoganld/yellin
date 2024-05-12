Rails.application.routes.draw do
  root "static_pages#home"
  get "secret", to: "static_pages#secret"
  mount Yellin::Engine => "/"
end
