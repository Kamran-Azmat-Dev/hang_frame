module CustomFrame
  class MouldingType < ApplicationRecord
    has_many :moulding_type_prices, class_name: 'CustomFrame::MouldingTypePrice'

    validates :name, presence: true, uniqueness: true
  end
end
