class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :type_id
      t.integer :student_id
      t.integer :platform_id
      t.string :ip
      t.string :email
      t.string :verify_code
      t.boolean :status
      t.timestamps
    end
  end
end
