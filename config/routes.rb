Rails.application.routes.draw do
  resource :fedora, only: [:show]
  resources :fedora_resources
  root to: 'fedora#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
