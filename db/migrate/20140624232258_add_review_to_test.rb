class AddReviewToTest < ActiveRecord::Migration
  def change
    add_column :tests, :review, :integer
  end
end
