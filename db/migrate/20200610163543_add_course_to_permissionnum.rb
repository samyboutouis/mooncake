class AddCourseToPermissionnum < ActiveRecord::Migration[6.0]
  def change
    add_reference :permissionnums, :course, null: false, foreign_key: true
  end
end
