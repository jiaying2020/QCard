class User < ApplicationRecord
  #validates
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /[\w]+@([\w-]+\.)+[\w-]{2,4}/ }
  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 4 }
  validates :nickname, presence: true

  before_create :encrypt_password
  
  has_many :posts
  has_many :comments

  has_many :favorite_posts
  has_many :my_favorites, through: :favorite_posts, source: 'post'

  def self.login(user)
    pw = Digest::SHA1.hexdigest("a#{user[:password]}z")
    User.find_by(email: user[:email], password: pw)
  end

  def favorite?(post)
    my_favorites.include?(post)
  end


  private
  def encrypt_password
    self.password = Digest::SHA1.hexdigest("a#{self.password}z")
  end
end
    
    # 增加加密複雜度「頭尾加密，或是加字串」
    #灑鹽法 salting encrypt
    #驗證寫法:https://railsbook.tw/chapters/19-model-validation-and-callback.html
    # 2.5 format
    # before_save跟before_create差別：觸發條件不同
    # before_save：每次存檔的時候都會經過
    # before_create 只有在「新增」的時候才會觸發

  