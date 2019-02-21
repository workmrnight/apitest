class DetailController < ApplicationController
  def detail
      logger.debug("ここまできてるよ")
       logger.debug (params[:tel]) 
 require 'net/http'
    logger.debug("ここ")
    # hash形式でパラメタ文字列を指定し、URL形式にエンコード
    # params = URI.encode_www_form([["areacode_l","AREAL2142"],["category_s","RSFST18008"]])
    #  @projects = Detail .order(params[:id])
     @tel = params[:tel]
     logger.debug("ここま")
     params = URI.encode_www_form([["id",@id]])
    # URIを解析し、hostやportをバラバラに取得できるようにする
    uri = URI.parse("https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=1079280779f1c4a933c7c98e388a6933&#{params}")

    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query
     http = Net::HTTP.new(uri.host, uri.port) 

    http.use_ssl = true 

    req = Net::HTTP::Get.new(uri.request_uri) 
    res = http.request(req) 
    # puts res.code, res.msg 
    # puts res.body 
    @result = JSON.parse(res.body) 
    @rest = @result["rest"]
    
    # 例外処理の開始
    begin
      # responseの値に応じて処理を分ける
      case res
      #case response
      # 成功した場合
      when Net::HTTPSuccess
        # responseのbody要素をJSON形式で解釈し、hashに変換
        # # 表示用の変数に結果を格納
        # @name = @result["rest"][0]["name"]
        # @address = @result["rest"][0]["address"]
        # @tel= @result["rest"][0]["tel"]
        # @category = @result["rest"][0]["category"]
        # @access = @result["rest"][0]["access"]
        
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
  
  def test
    
  end
  
end
