module Spree
  module Stock
    module PrioritizerDecorator
      # Default implementation only considers shipment and variant here. If there are two items inside
      # one shipment with the same variant, one of them gets lost as they get overwritten in hash where
      # they are stored. I changed the way they're hashed, so that every line item is treaded uniquely.
      def hash_item(item)
        shipment = item.inventory_unit.shipment
        variant = item.inventory_unit.variant
        line_item = item.inventory_unit.line_item

        if shipment.present?
          line_item.hash ^ variant.hash ^ shipment.hash
        else
          line_item.hash ^ variant.hash
        end
      end
    end
  end
end

::Spree::Stock::Prioritizer.prepend(Spree::Stock::PrioritizerDecorator)
