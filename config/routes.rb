Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :logins, only: [:new, :create, :destroy]
  get 'signup',to: "users#new",as: "signup"
  get 'signin', to: "logins#new",as: "signin"
  get "logout", to: "logins#destroy",as: "logout"
  get "events/invite/:id", to: "events#event_happenings",as: "invite"
  get "events/destroy/:id", to: "events#event_happenings_destroy",as: "destroy_invite"
  resources :users
  root to:"users#index"
  resources :events, only: [:new, :create, :show]
end
