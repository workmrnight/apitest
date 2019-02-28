class SearchController < ApplicationController
 
  def result
    # ViewのFormで取得したパラメータをモデルに渡す
    @users = User.search(params[:search])
  end
 
 
end