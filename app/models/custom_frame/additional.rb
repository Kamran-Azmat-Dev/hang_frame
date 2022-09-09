module CustomFrame
  class Additional < ApplicationRecord
    self.table_name = 'additionals'
    enum presentation_type: %w[input checkbox radio]

    with_options presence: true do
      validates :name, :presentation_type, :price
    end

    def self.search_by_name(name)
      where('LOWER(name) LIKE ?', "%#{name}%")
    end
  end
end
