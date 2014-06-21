class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :user_id
      t.integer :teacher_id
      t.timestamps
    end
  end
end
