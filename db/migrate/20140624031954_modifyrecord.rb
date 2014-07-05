class Modifyrecord < ActiveRecord::Migration
  def change
  	rename_column :reports, :teacher_id, :subject_id
  	rename_column :homeworks, :teacher_id, :subject_id
  	rename_column :tests, :teacher_id, :subject_id
  end
end
