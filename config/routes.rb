Rails.application.routes.draw do
  resources :users, only: [:create, :new] do
    resources :subs
  end
  resource :session, only: [:new, :create, :destroy]
end
