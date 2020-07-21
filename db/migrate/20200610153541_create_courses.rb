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
      t.boolean :primary
      t.text :cross_listing, array: true, default: [].to_yaml
      t.timestamps
    end
  end
end
