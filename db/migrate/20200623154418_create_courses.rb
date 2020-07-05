class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :department
      t.string :course_number
      t.string :section_number
      t.integer :capacity
      t.integer :seats_taken
      t.string :term
      t.boolean :published
      t.text :cross_listing, default: [].to_yaml
      t.boolean :primary

      t.timestamps
    end
  end
end
