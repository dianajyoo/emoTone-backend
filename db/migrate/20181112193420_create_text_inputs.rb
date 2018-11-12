class CreateTextInputs < ActiveRecord::Migration[5.2]
  def change
    create_table :text_inputs do |t|
      t.string :text

      t.timestamps
    end
  end
end
