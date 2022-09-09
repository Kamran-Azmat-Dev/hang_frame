module Spree
  module CartControllerDecorator
    private

    def add_item_service
      Spree::Cart::AddItem
    end
  end
end
::Spree::Api::V2::Storefront::CartController.prepend(Spree::CartControllerDecorator)
