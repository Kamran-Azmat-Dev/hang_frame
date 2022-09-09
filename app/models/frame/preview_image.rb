# frozen_string_literal: true

module Frame
  class PreviewImage < ApplicationRecord
    BORDER_PATTERN = 'border_pattern'
    CHEVRON = 'chevron'

    belongs_to :variant, class_name: 'Spree::Variant'

    validates :name,
              uniqueness: {
                scope: :variant,
                message: 'Already exists for this variant'
              },
              inclusion: {
                in: [BORDER_PATTERN, CHEVRON],
                message: 'Name must be one of: \'border_pattern\', \'chevron\''
              }

    validates :border_width, numericality: { greater_than: 0 }, allow_blank: true
    validates :border_pattern_repeats, numericality: { greater_than: 0 }, allow_blank: true

    has_one_attached :attachment

    validate :check_attachment_presence
    validate :check_attachment_content_type

    def accepted_image_types
      %w[image/jpeg image/jpg image/png]
    end

    def check_attachment_presence
      errors.add(:attachment, :attachment_must_be_present) unless attachment.attached?
    end

    def check_attachment_content_type
      invalid_content_type = attachment.attached? && !attachment.content_type.in?(accepted_image_types)
      errors.add(:attachment, :not_allowed_content_type) if invalid_content_type
    end
  end
end
