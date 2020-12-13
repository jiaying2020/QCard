class Comment < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  default_scope { where(deleted_at: nil).order(id: :desc) }


  # def destroy
  #   update(deleted_at: Time.now)
  # end

end


# model
# scope :cheap, -> { where("price < 50") }
# scope :forb, -> { where("age >= 18") }
# scope :x, -> { cheap.forb }
# defautl_scope { }

# # controller
# Product.forb.cheap
# Product.x

# default_scope { where(deleted_at: nil) }  
# default_scope 會全部強迫外掛預設查詢
# 要解除需要寫unscope