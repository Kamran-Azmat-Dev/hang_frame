class CreateOriginalArtTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :original_art_types do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
