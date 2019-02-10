Rails.application.routes.draw do
  get 'address/show'
  root to: 'address#show'
  
  get 'address/detail'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
