module Spree
  module V2
    module Storefront
      module LineItemSerializerDecorator
        def self.prepended(base)
          base.has_many :adjustments
          base.has_one :hang_photo
          base.has_one :mount_color
          base.has_one :accent_mount_color
        end
      end
    end
  end
end

::Spree::V2::Storefront::LineItemSerializer.prepend(Spree::V2::Storefront::LineItemSerializerDecorator)
