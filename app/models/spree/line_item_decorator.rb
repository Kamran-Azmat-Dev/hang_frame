# frozen_string_literal: true

module Spree
  module LineItemDecorator
    def self.prepended(base)
      base.belongs_to :hang_photo, class_name: 'HangPhoto'
      base.belongs_to :print_size, class_name: 'CustomFrame::PrintSize'
      base.belongs_to :mount_color, class_name: 'CustomFrame::MountColor'
      base.belongs_to :accent_mount_color, class_name: 'CustomFrame::MountColor'

      base.delegate :frame?, to: :product
    end

    class MissingPriceCalculationError < StandardError; end

    def foil_blocking_adjustment
      adjustments.custom_mount_additionals.find { |e| e.notes.starts_with?('foil_blocking') }
    end

    def linen_adjustment
      adjustments.custom_mount_additionals.find { |e| e.notes.starts_with?('linen') }
    end

    def custom?
      hang_photo.present? && hang_photo.type.eql?('custom')
    end

    def original_art?
      hang_photo.present? && hang_photo.type.eql?('original')
    end

    def total
      return amount + adjustment_total if hang_photo.nil?
      return amount if custom? || original_art?

      super
    end

    def update_price
      if self.foil_blocking
        self.price = correct_price + 0.15e2 if self.price >= self.variant.price && self.price < self.variant.price + 0.15e2
      else
        self.price = correct_price
      end
      # self.price =  && self.variant.price + 0.15e2 !== self.price ? correct_price + 0.15e2 : correct_price
    end

    def correct_price
      currency_price = variant.price_in(order.currency)
      # rubocop:disable Layout/LineLength
      return currency_price.price_including_vat_for(tax_zone: tax_zone) if !currency_price.amount.zero? && (!custom? && !original_art?)
      # rubocop:enable Layout/LineLength
      return price if custom? || original_art?

      raise MissingPriceCalculationError
    end
  end
end
::Spree::LineItem.prepend(Spree::LineItemDecorator)
