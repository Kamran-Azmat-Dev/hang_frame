require 'csv'

module Import
  class Products < Base
    prepend Spree::ServiceModule::Base

    def call
      add_option_types
      add_moulding_option_values
      add_print_size_option_values
      add_mount_color_option_values
      add_frame_types_taxons

      import_standard_products(file_path: file_path)
    end

    private

    def import_standard_products(file_path:)
      CSV.open(file_path, headers: true, col_sep: ';', header_converters: [->(v) { custom_converter(v) }]).each do |row|
        next if row.fields.compact.empty?

        build_standard_product(row: row)
      end
    end

    def add_option_types
      ['Moulding Type', 'Print Size', 'Mount Color'].each do |option_name|
        Spree::OptionType.where(name: custom_converter(option_name), presentation: option_name).first_or_create!
      end
    end

    def add_moulding_option_values
      option_type = Spree::OptionType.find_by(name: 'moulding_type')
      %w[Ansel Irving Brancaster Perlino].each do |option_value|
        option_type.option_values.find_or_create_by!(
          name: custom_converter(option_value),
          presentation: option_value
        )
      end
    end

    def add_print_size_option_values
      option_type = Spree::OptionType.find_by(name: 'print_size')
      %w[152x102 178x127 203x254].each do |option_value|
        option_type.option_values.find_or_create_by!(
          name: option_value,
          presentation: option_value
        )
      end
    end

    def add_mount_color_option_values
      option_type = Spree::OptionType.find_by(name: 'mount_color')
      colors = [{ name: 'white', value: '#fff' }, { name: 'black', value: '#000' }, { name: 'brown', value: '#8B5F4D' }]
      colors.each do |option_value|
        option_type.option_values.find_or_create_by(
          name: option_value[:name],
          presentation: option_value[:value]
        )
      end
    end

    def add_frame_types_taxons
      categories = Spree::Taxonomy.where(name: I18n.t('spree.taxonomy_categories_name')).first_or_create!
      categories_taxon = Spree::Taxon.where(name: I18n.t('spree.taxonomy_categories_name')).first_or_create!

      %w[Standard Custom].each do |taxon_name|
        taxon = categories_taxon.children.where(name: taxon_name).first_or_create!
        taxon.permalink = taxon.permalink.gsub('categories/', '')
        taxon.taxonomy = categories
        taxon.save!
      end
    end

    def standard_option_types
      Spree::OptionType.where(name: %w[moulding_type print_size mount_color])
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def build_standard_product(row:)
      product = Spree::Product.create(
        name: row['name'],
        price: row['price'],
        cost_price: row['price'],
        currency: 'GBP',
        short_description: row['short_description'],
        description: row['description'],
        shipping_category: default_shipping_category,
        available_on: DateTime.now,
        is_donation: false,
        is_gift_wrapped: false,
        is_pickup: false,
        option_types: standard_option_types,
        taxons: [Spree::Taxon.find_by(name: 'Standard')]
      )

      product.master.update(cost_currency: 'GBP', price: row['price'], cost_price: row['price'])
      product.master.prices.first.update(amount: row['price'])

      product.variants.new(
        option_values: find_option_values(values: [row['moulding_type'], row['print_size'], row['mount_color']]),
        price: row['price'],
        cost_price: row['price'],
        is_master: false
      ).save!
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def file_path
      "#{Rails.root}/spec/fixtures/import/products.csv"
    end
  end
end
