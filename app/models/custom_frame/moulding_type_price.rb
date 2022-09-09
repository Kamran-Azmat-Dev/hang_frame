module CustomFrame
  class MouldingTypePrice < ApplicationRecord
    belongs_to :moulding_type, class_name: 'CustomFrame::MouldingType'
    belongs_to :print_size, class_name: 'CustomFrame::PrintSize'

    validates :price, presence: true
    validates :print_size, uniqueness: {
      scope: :moulding_type,
      message: 'should be defined only once for moulding type and print size'
    }

    validates :moulding_type, uniqueness: {
      scope: :print_size,
      message: 'should be defined only once for moulding type and print size'
    }
  end
end
