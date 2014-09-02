class Addid < ActiveRecord::Migration
  def change
  	add_index :subjects, [:id, :teacher_id]
  	add_index :comments, [:id, :subject_id, :teacher_id, :user_id]
  	add_index :teachers, [:id]
  	add_index :users, [:id, :type_id, :platform_id]
  end
end
