module CustomFrame
  class MouldingTypePricePresenter
    def initialize(moulding_type_price)
      @moulding_type_price = moulding_type_price
    end

    def to_h
      {
        'mouldingTypeId' => moulding_type_price.moulding_type_id,
        'printSizeId' => moulding_type_price.print_size_id,
        'price' => moulding_type_price.price.to_s
      }
    end

    private

    attr_reader :moulding_type_price
  end
end
