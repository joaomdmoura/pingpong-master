Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  scope '/user' do
    resources :games, only: [:index, :new, :create]
  end
end
