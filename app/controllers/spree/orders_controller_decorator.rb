module Spree
  module OrdersControllerDecorator
    def edit
      super
      @trees_for_life_product_decorator = build_trees_for_life_product_decorator
      @gift_wrap_product_decorator = build_gift_wrap_product_decorator
      @pickup_product_decorator = build_pickup_product_decorator
    end

    private

    def build_trees_for_life_product_decorator
      trees_for_life_product = Spree::Product.find_by(is_donation: true)
      return nil unless trees_for_life_product.present?

      ::Checkout::TreesForLifeProductPresenter.new(trees_for_life_product)
    end

    def build_gift_wrap_product_decorator
      gift_wrap_product = Spree::Product.find_by(is_gift_wrapped: true)
      return nil unless gift_wrap_product.present?

      ::Checkout::GiftWrapProductPresenter.new(gift_wrap_product)
    end
    def build_pickup_product_decorator
      pickup_product = Spree::Product.find_by(is_pickup: true)
      return nil unless pickup_product.present?

      ::Checkout::PickupProductPresenter.new(pickup_product)
    end
  end
end

::Spree::OrdersController.prepend(Spree::OrdersControllerDecorator)
