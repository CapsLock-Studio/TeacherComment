class Teacher < ActiveRecord::Base
  scope :pageinator, ->(number) {
    offset((20 * (@page-1)) + 1).limit(20)
  }
end
