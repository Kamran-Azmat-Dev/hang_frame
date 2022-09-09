module Spree
  module OrderUpdaterDecorator
    # rubocop:disable Metrics/AbcSize
    def update_adjustment_total
      recalculate_adjustments
      order.adjustment_total = custom_adjustments_excluded +
        shipments.sum(:adjustment_total) +
        adjustments.eligible.sum(:amount)
      order.included_tax_total = line_items.sum(:included_tax_total) + shipments.sum(:included_tax_total)
      order.additional_tax_total = line_items.sum(:additional_tax_total) + shipments.sum(:additional_tax_total)

      order.promo_total = line_items.sum(:promo_total) +
        shipments.sum(:promo_total) +
        adjustments.promotion.eligible.sum(:amount)

      update_order_total
    end
    # rubocop:enable Metrics/AbcSize

    def custom_adjustments_excluded
      counted_line_adjustments = [order.line_item_adjustments - order.line_item_adjustments.custom_frame].flatten

      return 0.0 if counted_line_adjustments.empty?

      counted_line_adjustments.sum(&:amount)
    end
  end
end
::Spree::OrderUpdater.prepend(Spree::OrderUpdaterDecorator)
