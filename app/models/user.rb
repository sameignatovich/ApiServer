class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
