module CustomFrame
  class FoilBlockingColor < ApplicationRecord
    self.table_name = 'foil_blocking_colors'

    acts_as_list

    validates :name, presence: true
    validates :display, presence: true

    default_scope { order(:position) }

    scope :active, -> { where(active: true) }
  end
end
