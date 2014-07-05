class Changcolume < ActiveRecord::Migration
  def change
  	rename_column :teachers, :department, :department_id
  end
end
