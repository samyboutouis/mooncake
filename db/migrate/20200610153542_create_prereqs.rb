class CreatePrereqs < ActiveRecord::Migration[6.0]
  def change
    create_table :prereqs do |t|
      t.string :name

      t.timestamps
    end
  end
end
