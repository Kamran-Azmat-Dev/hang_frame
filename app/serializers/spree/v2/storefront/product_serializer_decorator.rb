module Spree
  module V2
    module Storefront
      module ProductSerializerDecorator
        def self.prepended(base)
          base.attribute :custom, :is_donation
          base.attribute :custom, :is_gift_wrapped
          base.attribute :custom, :is_pickup
        end
      end
    end
  end
end

::Spree::V2::Storefront::ProductSerializer.prepend(Spree::V2::Storefront::ProductSerializerDecorator)
