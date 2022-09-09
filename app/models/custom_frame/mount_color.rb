# frozen_string_literal: true

module CustomFrame
  class MountColor < ApplicationRecord
    acts_as_list
    acts_as_paranoid

    has_many :mount_preview_images, class_name: '::CustomFrame::MountPreviewImage'

    default_scope { order(:position) }

    scope :active, -> { where(active: true) }

    with_options presence: true do
      validates :name, :presentation
    end
  end
end
