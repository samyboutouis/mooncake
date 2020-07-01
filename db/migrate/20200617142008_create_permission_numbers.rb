class CreatePermissionNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :permission_numbers do |t|
      t.integer :number
      t.string :expire_date
      t.boolean :used
      t.references :course, null: false, foreign_key: true
      t.references :course_request, foreign_key: true

      t.timestamps
    end
  end
end
