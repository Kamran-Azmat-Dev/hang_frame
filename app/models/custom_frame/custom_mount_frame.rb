module CustomFrame
    class CustomMountFrame < ApplicationRecord
        has_many :custom_preferences, class_name: 'CustomFrame::CustomMountPreference', inverse_of: :custom_mount_frame
    end
end
