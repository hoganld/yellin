Rails.application.routes.draw do
  root "static_pages#home"
  mount Briscoe::Engine => "/"
end
