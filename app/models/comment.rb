class Comment < ActiveRecord::Base
  scope :pageinator, ->(page = 1, size = 20) { 
    offset((size * (page.to_i - 1)) + 0).limit(size)
  }
  
  scope :with_select, ->() {
  	select(:id, :comment, :created_at)
  }
  
  scope :with_condition, ->(subject_id) {
  	where(subject_id: subject_id)
  }
  
  scope :get, ->(subject_id, page = 1) {
  	with_select.with_condition(subject_id).order("created_at DESC").pageinator(page)
  }
  
  belongs_to :subject
  
  def c_time
  	DateTime.parse(self.created_at.to_s).to_time.to_i.strftime('%Y/%m/%d %H:%m') if !self.created_at.nil?
  end
end
