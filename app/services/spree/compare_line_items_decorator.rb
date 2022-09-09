module Spree
  module CompareLineItemsDecorator
    def compare(line_item, options)
      # Spree uses this class across the whole application, by default in conjunction with checking
      # variant id match. In our case, frame line items are equal only if their id are equal
      # as there can be multiple line items for the same variant, but with different photos
      if line_item.frame?
        line_item.id == options['id']
      else
        true
      end
    end
  end
end

::Spree::CompareLineItems.prepend(Spree::CompareLineItemsDecorator)
