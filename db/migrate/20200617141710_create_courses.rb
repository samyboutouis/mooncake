class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_number
      t.integer :capacity
      t.string :department
      t.integer :seats_taken

      t.timestamps
    end
  end
end
