class AddTermToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :term, :string
  end
end
