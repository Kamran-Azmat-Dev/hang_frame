module CustomFrame
  class PrintSizeMountOption < ApplicationRecord
    self.table_name = 'print_size_mount_options'

    belongs_to :print_size, class_name: 'CustomFrame::PrintSize'
    belongs_to :mount_option, class_name: 'CustomFrame::MountOption'
  end
end
