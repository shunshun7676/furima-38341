class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #has_many :products
  #has_many :purchases

  # ユーザー情報
  with_options presence: true do
    validates :nickname
    validates :birthday
  end

  # 本人情報確認
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'Full-width characters' } do
    validates :first_name
    validates :family_name
    
    
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters' } do
    validates :first_name_kana
    validates :family_name_kana
  end
end