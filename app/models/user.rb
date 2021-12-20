class User < ApplicationRecord
  enum role: [ :blocked, :regular, :moderator, :admin ]
  has_one_attached :avatar
  has_secure_password
  has_many :tokens, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  default_scope { order(created_at: :desc) }

  scope :role, -> (role) { where(role: role) }
end
