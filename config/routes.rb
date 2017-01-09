Rails.application.routes.draw do
  resources :fedora_resources
  root to: 'fedora_resources#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
