class AddCustomMountFrameToCustomPreferences < ActiveRecord::Migration[6.1]
  def change
    add_reference :custom_preferences, :custom_mount_frame, foreign_key: true
  end
end
