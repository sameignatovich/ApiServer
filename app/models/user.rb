class User < ApplicationRecord
  enum role: [ :blocked, :regular, :moderator, :admin ]
  has_secure_password
  has_many :tokens, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :full_name, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [500, 500]
  end

  default_scope { order(created_at: :desc) }

  scope :role, -> (role) { where(role: role) }

  def to_param
    username
  end
end
