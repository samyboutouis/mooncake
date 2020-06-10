class CreatePermissionNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :permission_numbers do |t|
      t.references :course, null: false, foreign_key: true
      t.string :number
      t.string :expire_date
      t.references :course_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
