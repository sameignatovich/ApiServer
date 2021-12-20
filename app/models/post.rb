class Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, :through => :taggings

  validates :title, presence: true, length: { in: 10..100 }
  validates :text, presence: true, length: { in: 100..10000 }

  def tags_list=(tags)
    self.tags = tags.map do |tag|
      Tag.where(name: tag.strip.downcase).first_or_create!
    end
  end

  default_scope { order(created_at: :desc) }

  scope :username, -> (username) { joins(:user).where(user: { username: username }) }
  scope :tag, -> (tag_name) { joins(:tags).where(tags: { name: tag_name }) }
end
