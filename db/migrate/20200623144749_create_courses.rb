class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :section_number
      t.string :meeting_time
      t.integer :capacity

      t.timestamps
    end
  end
end
