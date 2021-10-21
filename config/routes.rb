Rails.application.routes.draw do
  resources :pins
  devise_for :users
  root 'pins#index'
  get 'home/about' => 'home#about'
  get 'home' => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
