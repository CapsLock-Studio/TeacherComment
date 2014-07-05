class DropTableHomework < ActiveRecord::Migration
  def change
  	drop_table :homeworks
  end
end
