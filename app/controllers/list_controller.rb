class ListController < ApplicationController
  PER = 5
  def show
    
    require 'net/http'
    require 'will_paginate/array'
    require 'json'
    
    # ページネーション用
    if !params[:page].blank?
      @pagenate = params[:page]
    end
   
   @pref = params[:pref]
   @freeword = params[:freeword]
    
    #フリーワード検索都道府県コードが入っているとき
    if !@freeword.blank? or !@pref.blank?
    @freeword = params[:freeword]
    @para = [["freeword",@freeword],["pref",@pref],["category_s","RSFST18002"],["hit_per_page",100]]
   
    #そうじゃないとき  
    else
    # hash形式でパラメタ文字列を指定し、URL形式にエンコード
   # params = URI.encode_www_form({zipcode: '7830060'})
    @para = [["areacode_s","AREAS2115"],["category_s","RSFST18002"],["hit_per_page",100]]
  end
  
   # URIエンコード
    logger.debug(@para)
   params = URI.encode_www_form(@para)
    uri = URI.parse("https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=1079280779f1c4a933c7c98e388a6933&#{params}")

    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query
     http = Net::HTTP.new(uri.host, uri.port) 

    http.use_ssl = true 

    req = Net::HTTP::Get.new(uri.request_uri) 
    res = http.request(req) #かえってきたすべて
    # puts res.code200　または400,404, res.msg 　コードで分岐。途中でreturn error のメッセージを返す。。
    # puts res.body 
    @result = JSON.parse(res.body) 
    
    if @result["error"].blank?
      logger.debug ("No Error!")
    else
      @err_code = @result["error"][0]["code"]
      @err_msg = @result["error"][0]["message"]
      logger.debug (@err_code)
    end
    
    @rest = @result["rest"]
    # ページネーション用
    @rest = @rest.paginate(page: @pagenate, per_page: PER)
    
    # 例外処理の開始
    begin
      # responseの値に応じて処理を分ける
      case res
      #case response
      # 成功した場合
      when Net::HTTPSuccess
        # responseのbody要素をJSON形式で解釈し、hashに変換
        # 表示用の変数に結果を格納
        @name = @result["rest"][0]["name"]
        @address = @result["rest"][0]["address"]
        @tel= @result["rest"][0]["tel"]
        @category = @result["rest"][0]["category"]
        @access = @result["rest"][0]["access"]
        
      # 別のURLに飛ばされた場合
      when Net::HTTPRedirection
        @message = "Redirection: code=#{res.code} message=#{res.message}"
      # その他エラー
      else
        @message = "HTTP ERROR: code=#{res.code} message=#{res.message}"
      end
    # エラー時処理
    rescue IOError => e
      @message = "e.message"
    rescue TimeoutError => e
      @message = "e.message"
    rescue JSON::ParserError => e
      @message = "e.message"
    rescue => e
      @message = "e.message"
    end
end

end
