class Tagging < ApplicationRecord
  belongs_to :post
  belongs_to :tag, counter_cache: :posts_count
end
