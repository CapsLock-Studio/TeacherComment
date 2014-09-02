class Addindex < ActiveRecord::Migration
  def change
  	add_index :teachers, [:id, :department_id]
  end
end
