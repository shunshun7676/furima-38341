class Product < ApplicationRecord
 belongs_to :user
 has_one :purchase
# has_many :comments

has_one_attached :image

end
