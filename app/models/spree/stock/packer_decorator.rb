module Spree
  module Stock
    module PackerDecorator
      # rubocop:disable Metrics/CyclomaticComplexity
      # rubocop:disable Metrics/PerceivedComplexity
      def default_package
        package = Package.new(stock_location)

        # Default implementation uses index_by here which causes issues when there are multiple line items
        # with the same variant_id - only one is considered then. I changed it to use group_by and then
        # iterate over these groups. This way we create proper packages in such situation.
        inventory_units.group_by(&:variant_id).each do |variant_id, inventory_units|
          variant = Spree::Variant.find(variant_id)

          inventory_units.each do |inventory_unit|
            unit = inventory_unit.dup # Can be used by others, do not use directly
            if variant.should_track_inventory?
              next unless stock_location.stocks? variant

              on_hand, backordered = stock_location.fill_status(variant, unit.quantity)
              package.add(InventoryUnit.split(unit, backordered), :backordered) if backordered.positive?
              package.add(InventoryUnit.split(unit, on_hand), :on_hand) if on_hand.positive?
            else
              package.add unit
            end
          end
        end

        package
      end
      # rubocop:enable Metrics/PerceivedComplexity
      # rubocop:enable Metrics/CyclomaticComplexity
    end
  end
end

::Spree::Stock::Packer.prepend(Spree::Stock::PackerDecorator)
