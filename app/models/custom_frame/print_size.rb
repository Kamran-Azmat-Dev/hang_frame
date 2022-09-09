module CustomFrame
  class PrintSize < ApplicationRecord
    self.table_name = 'print_sizes'

    acts_as_paranoid

    has_many :print_size_mount_types, class_name: 'CustomFrame::PrintSizeMountType'
    has_many :print_size_mount_options, class_name: 'CustomFrame::PrintSizeMountOption'
    has_many :print_size_additionals, class_name: 'CustomFrame::PrintSizeAdditional'
    has_many :moulding_type_prices, class_name: 'CustomFrame::MouldingTypePrice'

    has_many :mount_types, through: :print_size_mount_types
    has_many :mount_options, through: :print_size_mount_options
    has_many :additionals, through: :print_size_additionals

    scope :available, -> { where(visible: true) }

    with_options presence: true do
      validates :name, :label
      validates :shortest_side, :longest_side, numericality: { greater_than: 0 }
    end

    validate :uniq_standard_mount_type

    def custom_mount_type_preferences
      custom_mount_type.preferences.where(default_size: standard_mount_type.width)
    end

    def custom_mount_type
      mount_types.find_by(name: 'custom')
    end

    def dimensions
      "#{shortest_side} x #{longest_side}"
    end

    private

    def uniq_standard_mount_type
      errors.add(:mount_types, 'Cant add two Standard MountType') if find_standard_mount_type.size > 1
    end

    def require_standard_mount_type
      return true if mount_type_ids.empty?

      return errors.add(:mount_types, 'Standard MountType is required') if missing_standard_mount_type?
    end

    def missing_standard_mount_type?
      CustomFrame::MountType.where(id: mount_type_ids).select { |item| item.name == 'standard' }.empty?
    end

    def find_standard_mount_type
      mount_types.select { |item| item.name == 'standard' }
    end
  end
end
