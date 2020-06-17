class CreateJoinTableCourseRequestQuestion < ActiveRecord::Migration[6.0]
  def change
    create_join_table :course_requests, :questions do |t|
      # t.index [:course_request_id, :question_id]
      # t.index [:question_id, :course_request_id]
      t.string :answer
    end
  end
end
