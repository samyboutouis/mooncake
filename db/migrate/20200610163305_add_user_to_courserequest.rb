class AddUserToCourserequest < ActiveRecord::Migration[6.0]
  def change
    add_reference :courserequests, :user, null: false, foreign_key: true
  end
end
