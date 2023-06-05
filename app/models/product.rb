class Product < ApplicationRecord
extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to :user
has_one :purchase

belongs_to :category
belongs_to :prefecture
belongs_to :status
belongs_to :derively_fee
belongs_to :hi

has_one_attached :image

with_options presence: true do
validates :image
validates :name
validates :explanation
validates :category_id
validates :status_id
validates :derively_fee_id
validates :prefecture_id
validates :hi_id
# 300円以上かつ9,999,999円以下で、半角数字でないと入力不可
validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,only_integer: true }
end

# ジャンルの選択が「--」の時は保存不可
with_options numericality: { other_than: 0 } do
validates :category_id
validates :prefecture_id
validates :status_id
validates :derively_fee_id
validates :hi_id
end
end
