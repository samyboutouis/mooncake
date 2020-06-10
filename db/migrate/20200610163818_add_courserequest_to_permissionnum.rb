class AddCourserequestToPermissionnum < ActiveRecord::Migration[6.0]
  def change
    add_reference :permissionnums, :courserequest, null: false, foreign_key: true
  end
end
