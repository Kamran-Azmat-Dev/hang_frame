# frozen_string_literal: true

module CustomFrame
  class MountPreviewImage < ApplicationRecord
    MOUNT_PATTERN = 'mount_pattern'
    MOUNT_BORDER_TOP_LEFT = 'mount_border_top_left'
    MOUNT_BORDER_BOTTOM_RIGHT = 'mount_border_bottom_right'

    belongs_to :mount_color, class_name: '::CustomFrame::MountColor'

    validates :name, inclusion: {
      in: [MOUNT_PATTERN, MOUNT_BORDER_TOP_LEFT, MOUNT_BORDER_BOTTOM_RIGHT],
      message: 'Name must be one of: \'border_pattern\''
    }

    validates :width, numericality: { greater_than: 0 }, allow_blank: false
    validates :height, numericality: { greater_than: 0 }, allow_blank: false

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
