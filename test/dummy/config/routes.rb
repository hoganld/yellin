Rails.application.routes.draw do
  root "static_pages#home"
  mount Yellin::Engine => "/"
end
