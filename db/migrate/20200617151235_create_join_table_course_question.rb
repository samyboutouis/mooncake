class CreateJoinTableCourseQuestion < ActiveRecord::Migration[6.0]
  def change
    create_join_table :courses, :questions do |t|
      # t.index [:course_id, :question_id]
      # t.index [:question_id, :course_id]
    end
  end
end
