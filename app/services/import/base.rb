module Import
  class Base
    def find_option_values(values: [])
      values.map do |value|
        Spree::OptionValue.find_by(name: custom_converter(value))
      end
    end

    def default_shipping_category
      ::Spree::ShippingCategory.where(name: 'Default').first_or_create
    end

    def custom_converter(string)
      string.downcase.gsub(' ', '_')
    end
  end
end
