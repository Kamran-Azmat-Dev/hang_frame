module Checkout
  class PickupProductPresenter
    def initialize(product, currency = 'GBP')
      @product = product
      @currency = currency
    end

    def variant_id
      product.master.id
    end

    def name
      product.name
    end

    def price
      product.price_in(currency).try(:amount)
    end

    def to_h
      {
        'variantId' => variant_id,
        'name' => name,
        'price' => price
      }
    end

    private

    attr_reader :product, :currency
  end
end
