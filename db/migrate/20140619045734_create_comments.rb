class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :teacher_id
      t.integer :subject_id
      t.integer :user_id
      t.text :comment
      t.timestamps
    end
  end
end
