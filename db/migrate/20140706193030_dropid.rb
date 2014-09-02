class Dropid < ActiveRecord::Migration
  def change
  	remove_column :comments, :teacher_id
  end
end
