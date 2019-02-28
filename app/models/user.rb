class User < ApplicationRecord
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      User.where(['email LIKE ?', "%#{search}%"])
    else
      User.all #全て表示。
    end
  end
end