class User < ApplicationRecord
  enum role: [ :blocked, :regular, :admin ]
  has_one_attached :avatar
  has_secure_password
  has_many :tokens, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, format: { with: /\A[a-zA-Z0-9-_]+\z/, message: "only allows letters, numbers, _, -" }, length: { in: 4..20 }, presence: true, uniqueness: true
  validates :email, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "wrong format" }, length: { in: 6..64 }, presence: true, uniqueness: true

  default_scope { order(created_at: :desc) }

  scope :role, -> (role) { where(role: role) }
end
