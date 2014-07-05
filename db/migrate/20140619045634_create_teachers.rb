class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.integer :department
      t.string :avatar
      t.timestamps
    end
  end
end
