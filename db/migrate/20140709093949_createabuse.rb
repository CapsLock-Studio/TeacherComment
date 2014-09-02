class Createabuse < ActiveRecord::Migration
  def change
    create_table :abuses do |t|
      t.integer :comment_id
      t.string :verify_code
      t.timestamps
    end
  end
end
