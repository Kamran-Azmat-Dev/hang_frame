module Spree
  module Products
    module FindDecorator
      def execute
        products = by_ids(scope)
        products = by_skus(products)
        products = by_price(products)
        products = by_currency(products)
        products = by_taxons(products)
        products = by_concat_taxons(products)
        products = by_name(products)
        products = by_options(products)
        products = by_option_value_ids(products)
        products = include_deleted(products)
        products = include_discontinued(products)
        products = exclude_donation(products)
        products = ordered(products)

        products.distinct
      end

      private

      def exclude_donation(products)
        products.where(is_donation: false)
      end
    end
  end
end

::Spree::Products::Find.prepend(Spree::Products::FindDecorator)
