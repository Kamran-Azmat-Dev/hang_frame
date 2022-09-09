class AddDefaultPriceToMouldingTypePrices < ActiveRecord::Migration[6.1]
  def change
    change_column_default :moulding_type_prices, :price, 0.0
  end
end
