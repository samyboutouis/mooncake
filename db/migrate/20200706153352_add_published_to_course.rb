class AddPublishedToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :published, :boolean
  end
end
