class CreateTones < ActiveRecord::Migration[5.2]
  def change
    create_table :tones do |t|
      t.string :anger
      t.string :fear
      t.string :joy
      t.string :sadness
      t.string :analytical
      t.string :confident
      t.string :tentative
      t.references :text_input, foreign_key: true

      t.timestamps
    end
  end
end
