class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true
  validates :body, presence: true, length: { in: 1..1000 }
end
