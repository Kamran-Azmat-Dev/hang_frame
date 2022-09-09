module CustomFrame
  class PrintSizeAdditional < ApplicationRecord
    self.table_name = 'print_size_additionals'

    belongs_to :print_size, class_name: 'CustomFrame::PrintSize'
    belongs_to :additional, class_name: 'CustomFrame::Additional'
  end
end
