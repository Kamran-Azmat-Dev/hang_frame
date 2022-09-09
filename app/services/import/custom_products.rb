require 'csv'

module Import
  class CustomProducts < Base
    prepend Spree::ServiceModule::Base

    def call
      add_moulding_types

      import_custom_products(file_path: file_path)
    end

    private

    def add_moulding_types
      %w[Standard Premium Hardwoods].each do |name|
        CustomFrame::MouldingType.where(name: name).first_or_create!
      end
    end

    def import_custom_products(file_path:)
      CSV.open(file_path, headers: true, col_sep: ';', header_converters: [->(v) { custom_converter(v) }]).each do |row|
        next if row.fields.compact.empty?

        build_custom_product(row: row)
      end
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def build_custom_product(row:)
      option_type = Spree::OptionType.find_by(name: 'color')
      product = Spree::Product.create(
        name: row['frame_name'],
        price: 0,
        cost_price: 0,
        currency: 'GBP',
        short_description: row['short_description'],
        moulding_type: row['category'] ? CustomFrame::MouldingType.find_by(name: row['category'].capitalize) : nil,
        description: row['description'],
        shipping_category: default_shipping_category,
        available_on: DateTime.now,
        is_donation: false,
        is_gift_wrapped: false,
        is_pickup: false,
        custom: true,
        option_types: [option_type],
        taxons: [Spree::Taxon.find_by(name: 'Custom')]
      )

      product.master.update(cost_currency: 'GBP', price: 0, cost_price: 0)
      product.master.prices.first.update(amount: 0)

      puts row['filter']
      option_value = if row['filter']
                       option_type.option_values.find_by!(name: row['filter'])
                     else
                       option_type.option_values.first
                     end

      product.variants.new(
        option_values: [option_value],
        price: 0,
        cost_price: 0,
        is_master: false
      ).save!
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    def file_path
      "#{Rails.root}/spec/fixtures/import/custom_products.csv"
    end
  end
end
