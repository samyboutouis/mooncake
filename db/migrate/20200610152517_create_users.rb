class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :major
      t.integer :grad_year
      t.string :user_type

      t.timestamps
    end
  end
end
