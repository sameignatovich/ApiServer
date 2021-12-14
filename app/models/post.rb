class Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, counter_cache: true

  def tags_list=(tags)
    self.tags = tags.map do |tag|
      Tag.where(name: tag.strip.downcase).first_or_create!
    end
  end
end
