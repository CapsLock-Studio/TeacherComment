class Removeindex < ActiveRecord::Migration
  def change
  	remove_index :teachers, [:id]
  end
end
