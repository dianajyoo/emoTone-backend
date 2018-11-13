Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :text_inputs, only: [:index, :create, :show]

  # post '/text_inputs', to: 'text_inputs#index'
end
