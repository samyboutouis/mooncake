class CreateJoinTableCoursePrereq < ActiveRecord::Migration[6.0]
  def change
    create_join_table :courses, :prereqs do |t|
      # t.index [:course_id, :prereq_id]
      # t.index [:prereq_id, :course_id]
    end
  end
end
