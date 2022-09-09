# frozen_string_literal: true

module Spree
  module ProductDecorator
    def self.prepended(base)
      base.scope :custom_frames, -> { where(custom: true) }
      base.scope :standard_frames, -> { where(custom: false) }

      base.has_many :active_variants,
                    -> { active.where(is_master: false).order(:position) },
                    inverse_of: :product,
                    class_name: 'Spree::Variant'

      base.has_many :variant_frame_preview_images,
                    -> { order(:variant_id) },
                    source: :frame_preview_images,
                    through: :variants_including_master

      base.belongs_to :moulding_type, class_name: 'CustomFrame::MouldingType', optional: true

      base.validates_uniqueness_of :is_donation, if: :is_donation
      base.validates_uniqueness_of :is_gift_wrapped, if: :is_gift_wrapped
      base.validates_uniqueness_of :is_pickup, if: :is_pickup
    end

    def frame?
      !is_donation? && !is_gift_wrapped? && !is_pickup?
    end

    def standard?
      !custom?
    end
  end
end
::Spree::Product.prepend(Spree::ProductDecorator)
