class AddBorderWidthAndBorderPatternRepeatsToFramePreviewImages < ActiveRecord::Migration[6.1]
  def change
    add_column :preview_images, :border_width, :decimal, precision: 10, scale: 2
    add_column :preview_images, :border_pattern_repeats, :decimal, precision: 10, scale: 2
  end
end
