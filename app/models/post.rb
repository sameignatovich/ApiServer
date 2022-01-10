class Post < ApplicationRecord
  has_rich_text :content
  enum status: [:draft, :published, :hidden, :blocked]
  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, :through => :taggings

  validates :title, presence: true
  validates :content, presence: true

  def tags_list=(tags)
    self.tags = tags.map do |tag|
      Tag.where(name: tag.strip.downcase).first_or_create!
    end
  end

  default_scope { order(created_at: :desc) }

  scope :username, -> (username) { joins(:user).where(user: { username: username }) }
  scope :tag, -> (tag_name) { joins(:tags).where(tags: { name: tag_name }) }
end
