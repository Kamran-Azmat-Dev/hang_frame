# frozen_string_literal: true

module Spree
  module AdjustmentDecorator
    def self.prepended(base)
      base.scope :custom_mount_type, -> { where(source_type: 'CustomFrame::MountType') }
      base.scope :custom_mount_option, -> { where(source_type: 'CustomFrame::MountOption') }
      base.scope :custom_mount_additionals, -> { where(source_type: 'CustomFrame::Additional') }
      base.scope :custom_moulding_type_prices, -> { where(source_type: 'CustomFrame::MouldingTypePrice') }

      base.scope :custom_frame, (lambda do
        where(source_type: [
                'CustomFrame::MountType',
                'CustomFrame::MountOption',
                'CustomFrame::Additional',
                'CustomFrame::MouldingTypePrice'
              ])
      end)
    end
  end
end
::Spree::Adjustment.prepend(Spree::AdjustmentDecorator)
