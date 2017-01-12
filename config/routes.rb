Rails.application.routes.draw do
  resources :fedora, only: [:index, :show]
  resources :fedora_resources
  root to: 'fedora#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
