module Spree
  module Calculator::FlatPercentItemTotalDecorator
    def compute(object)
      computed_amount = (object_amount(object) * preferred_flat_percent / 100).round(2)

      # We don't want to cause the promotion adjustments to push the order into a negative total.
      if computed_amount > object.amount
        object.amount
      else
        computed_amount
      end
    end

    def object_amount(object)
      return object.amount - object.donation_line_items.sum(&:amount) - object.gift_wrapped_line_items.sum(&:amount) if object.is_a?(Spree::Order)
      return object.amount if object.is_a?(Spree::LineItem) && !object.custom?

      object.amount
    end
  end
end
::Spree::Calculator::FlatPercentItemTotal.prepend(Spree::Calculator::FlatPercentItemTotalDecorator)
