class AddUserToFormTemplate < ActiveRecord::Migration[6.0]
  def change
    add_reference :form_templates, :user, null: false, foreign_key: true
  end
end
