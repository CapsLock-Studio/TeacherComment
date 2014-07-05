class AddAvatarToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :avatar, :string
  end
end
