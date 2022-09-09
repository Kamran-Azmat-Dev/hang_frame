module CustomFrame
  class CustomMountPreference < ApplicationRecord
    self.table_name = 'custom_preferences'

    belongs_to :mount_type, class_name: 'CustomFrame::MountType'
    belongs_to :custom_mount_frame, class_name: 'CustomFrame::CustomMountFrame'

    with_options presence: true do
      validates :default_size, :min_value, :max_value, :price
      validates :max_value, numericality: { greater_than: 0 }
    end

    # add method for calculate min_value from default_size if empty
  end
end
