class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :products
         has_many :purchases
         
         with_options presence: true do
          validates :nickname
          validates :birthday
        end
      
        validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/, message: "can't be blank" }
        validates :password, format: { with: /\A[a-z0-9]+\z/i, message: 'Include both letters and numbers' }, allow_nil: true
      end