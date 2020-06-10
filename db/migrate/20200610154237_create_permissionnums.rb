class CreatePermissionnums < ActiveRecord::Migration[6.0]
  def change
    create_table :permissionnums do |t|
      t.string :expire_date
      t.string :number

      t.timestamps
    end
  end
end
