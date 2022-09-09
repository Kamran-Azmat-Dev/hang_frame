module OriginalArt
  class Type < ApplicationRecord
    self.table_name = 'original_art_types'

    scope :active, -> { where(active: true) }

    validates :name, presence: true
  end
end
