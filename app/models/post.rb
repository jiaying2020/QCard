class Post < ApplicationRecord
  acts_as_paranoid
  extend FriendlyId
  friendly_id :title, use: :slugged
#  12/11-套件

  belongs_to :board
  belongs_to :user
  has_many :comments
  
  has_many :favorite_posts
  has_many :my_posts, through: :favorite_posts, source: 'post'

  validates :title, presence: true
  validates :content, presence: true
  # has_many :posts
  

  def owned_by?(user)
    self.user == user
  end

end

# p1.owned_by_a?(user, p1)

# p1.owned_by_b?(user)
# p2.owned_by_b?(user)

# p1.owned_by?(u1) #true
# p1.owned_by?(u2) #false



# u1: p1 p2
# u2: p3
