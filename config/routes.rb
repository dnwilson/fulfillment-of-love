Rails.application.routes.draw do
  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout",
    password: "passwords",
    confirmations: "confirmations"
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  resources :checkouts,  only: [:new, :create, :show, :index]

  # get   "login",  to: "devise/sessions#new"
  # get   "logout", to: "devise/sessions#destroy"

  root 'pages#home'
end
