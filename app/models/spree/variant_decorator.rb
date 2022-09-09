# frozen_string_literal: true

module Spree
  module VariantDecorator
    def self.prepended(base)
      base.has_many :frame_preview_images, class_name: 'Frame::PreviewImage', dependent: :destroy
    end
  end
end
::Spree::Variant.prepend(Spree::VariantDecorator)
