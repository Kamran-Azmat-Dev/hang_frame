module CustomFrame
  class MountOption < ApplicationRecord
    validates :top, :left, :right, :bottom, numericality: { greater_than_or_equal_to: 0.0 }, allow_blank: false

    # add unique validator for: left top right bottom
    def self.search_by_name(name)
      where('LOWER(name) LIKE ?', "%#{name}%")
    end

    def formatted_label
      "#{label} - #{dimenssion}"
    end

    def dimenssion
      "#{left}x#{top}x#{right}x#{bottom}"
    end
  end
end
