class Subject < ActiveRecord::Base
  scope :pageinator, ->(page = 1, size = 4) {
    offset((size * (page.to_i - 1)) + 0).limit(size)
  }
  belongs_to :teacher
  has_many :comment
end
