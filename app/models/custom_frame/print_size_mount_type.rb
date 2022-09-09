module CustomFrame
  class PrintSizeMountType < ApplicationRecord
    self.table_name = 'print_size_mount_types'

    belongs_to :print_size, class_name: 'CustomFrame::PrintSize'
    belongs_to :mount_type, class_name: 'CustomFrame::MountType'
  end
end
