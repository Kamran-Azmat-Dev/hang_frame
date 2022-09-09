module CustomFrame
  class MountType < ApplicationRecord
    self.table_name = 'mount_types'

    with_options presence: true do
      validates :name, :label, :price
    end

    validates_uniqueness_of :width, conditions: -> { where(name: 'standard') }
    validates_uniqueness_of :name, conditions: -> { where(name: 'custom') }

    has_many :custom_preferences, class_name: 'CustomFrame::CustomMountPreference', inverse_of: :mount_type
    alias_attribute :preferences, :custom_preferences

    def self.search_by_name(name)
      where('LOWER(name) LIKE ?', "%#{name}%")
    end

    def formatted_label
      return label if width.zero?

      "#{label} - width: #{width}"
    end
  end
end
