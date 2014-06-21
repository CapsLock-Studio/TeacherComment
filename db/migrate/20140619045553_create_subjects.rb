class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :teacher_id
      t.string :name
      t.timestamps
    end
  end
end
