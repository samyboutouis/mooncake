class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :major
      t.string :grad_year
      t.string :user_type
      t.string :unique_id
      t.string :net_id
      t.string :email

      t.timestamps
    end
  end
end
