Rails.application.routes.draw do
  root "static_pages#home"
  mount Miniauth::Engine => "/"
end
