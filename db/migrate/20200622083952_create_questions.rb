class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question_type
      t.string :question_text
      t.text :option, array: true, default: [].to_yaml

      t.timestamps
    end
  end
end
