class CreateCourserequests < ActiveRecord::Migration[6.0]
  def change
    create_table :courserequests do |t|
      t.string :status

      t.timestamps
    end
  end
end
