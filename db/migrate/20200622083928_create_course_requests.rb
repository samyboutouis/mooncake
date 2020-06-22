class CreateCourseRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :course_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
