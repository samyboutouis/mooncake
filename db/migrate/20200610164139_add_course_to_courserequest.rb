class AddCourseToCourserequest < ActiveRecord::Migration[6.0]
  def change
    add_reference :courserequests, :course, null: false, foreign_key: true
  end
end
