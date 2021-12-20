class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :posts, :through => :taggings

  validates :name, presence: true, length: { in: 1..16 }, uniqueness: true
end
