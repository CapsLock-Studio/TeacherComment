class AddDepartmentToTeacher < ActiveRecord::Migration
  def change
    change_column :teachers, :department, :integer
  end
end
