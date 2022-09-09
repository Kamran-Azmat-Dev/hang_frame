module Spree
  module CheckoutControllerDecorator
    def self.prepended(base)
      base.layout 'spree/layouts/spree_application'
    end
  end
end

::Spree::CheckoutController.prepend(Spree::CheckoutControllerDecorator)
