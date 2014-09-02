class Teacher < ActiveRecord::Base
  scope :pageinator, ->(page = 1, size = 10) {
    offset((size * (page.to_i - 1)) + 0).limit(size)
  }
  
  scope :with_condition, ->(condition, bind) {
  	where(condition, bind)
  }

  scope :with_select, ->() {
  	select(:id, :name, :department_id, :avatar)
  }

  scope :find_with_condition, ->(condition, bind, page = 1) {
  	with_select.with_condition(condition, bind).pageinator(page)
  }

  has_many :subject, :dependent => :destroy
  has_many :comment, through: :subject, :dependent => :destroy
end
