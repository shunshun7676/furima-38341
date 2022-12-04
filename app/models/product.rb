class Product < ApplicationRecord
 belongs_to :user
 has_one :purchase
# has_many :comments
end
