class CreateJoinTableCourserequestQuestion < ActiveRecord::Migration[6.0]
  def change
    create_join_table :courserequests, :questions do |t|
      # t.index [:courserequest_id, :question_id]
      # t.index [:question_id, :courserequest_id]
    end
  end
end
