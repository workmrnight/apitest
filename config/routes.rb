Rails.application.routes.draw do
  get 'address/show'
  root to: 'address#show'
  
  # get 'detail/detail'
  get 'detail/detail/:id' => 'detail#detail',as:'detail_detail'
  # get 'detail/detail/:id'=> 'detail#detail'
  # => 'detail#detail',as:'detail_detail'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


