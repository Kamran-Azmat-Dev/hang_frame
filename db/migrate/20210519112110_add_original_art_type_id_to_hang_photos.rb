class AddOriginalArtTypeIdToHangPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :hang_photos, :original_art_type_id, :integer
  end
end
