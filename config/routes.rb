Rails.application.routes.draw do
  get 'main/index'
  root to: 'main#index'
    
  get 'search/show'
#   root to: 'list#show'
  
  # get 'detail/detail'
  get 'detail/detail/:id' => 'detail#detail',as:'detail_detail' # => はto  root/detail/detail # このパスが呼ばれたときの挙動
  

  # get 'detail/detail/:id'=> 'detail#detail'
  # => 'detail#detail',as:'detail_detail'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   get 'free' => 'search#free',as:'search_free'
   get 'main/area'
end


