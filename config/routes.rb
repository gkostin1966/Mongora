Rails.application.routes.draw do
  get 'fedora', controller: :fedora, action: :index, as: :fedora
  get 'fedora/*id', controller: :fedora, action: :show, as: :fedora_node
  root to: 'fedora#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
