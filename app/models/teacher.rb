class Teacher < ActiveRecord::Base
  scope :pageinator, ->(page = 1, size = 10) {
    offset((size * (page.to_i - 1)) + 0).limit(size)
  }
  has_many :subject
end
