class AddTeacherIdToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :teacher_id, :integer
  end
end
