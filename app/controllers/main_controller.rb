class MainController < ApplicationController
    def index
    end
    
    def area
    require 'net/http'
    require 'will_paginate/array'
    require 'json'
   
   @pref = params[:pref]
    
    #検索都道府県コードが入っているとき
    if !@pref.blank?
      @para = [["pref",@pref],["hit_per_page",100]]
  end
  
   # URIエンコード
    logger.debug(@para)
   params = URI.encode_www_form(@para)
    uri = URI.parse("https://api.gnavi.co.jp/master/GAreaSmallSearchAPI/v3/?keyid=1079280779f1c4a933c7c98e388a6933&#{params}")

    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query
     http = Net::HTTP.new(uri.host, uri.port) 

    http.use_ssl = true 

    req = Net::HTTP::Get.new(uri.request_uri) 
    res = http.request(req) #かえってきたすべて
    # puts res.code200　または400,404, res.msg 　コードで分岐。途中でreturn error のメッセージを返す。。
    # puts res.body 
    @result = JSON.parse(res.body) 
    @rest = @result["rest"]

end
end