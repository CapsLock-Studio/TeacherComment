class Comment < ActiveRecord::Base
  scope :pageinator, ->(page = 1, size = 20) { 
    offset((size * (page.to_i - 1)) + 0).limit(size)
  }
  belongs_to :subject

  def c_time
  	DateTime.parse(self.created_at.to_s).to_time.to_i.strftime('%Y/%m/%d %H:%m') if !self.created_at.nil?
  end
end
