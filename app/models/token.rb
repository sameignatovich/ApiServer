class Token < ApplicationRecord
  enum status: [ :inactive, :active ]
  belongs_to :user, counter_cache: true
end
