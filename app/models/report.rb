class Report < ActiveRecord::Base
  scope :positive, ->(subject_id) {
    where(:subject_id => subject_id, :review => 1).count(:id)
  }
  
  scope :negative, ->(subject_id) {
    where(:subject_id => subject_id, :review => -1).count(:id)
  }

  belongs_to :subject
end
