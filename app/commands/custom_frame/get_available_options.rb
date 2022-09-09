module CustomFrame
  class GetAvailableOptions
    attr_reader :print_size

    def initialize(print_size: CustomFrame::CustomerPrintSizeQuery.new)
      @print_size = print_size
    end

    def call(width, height)
      matching_print_size = print_size.call(width, height)
      return nil unless matching_print_size.present?

      print_size_with_associations = CustomFrame::PrintSize.preload(
        :mount_options,
        :additionals,
        :moulding_type_prices,
        mount_types: [:custom_preferences]
      ).find(matching_print_size.id)

      CustomFrame::OptionsPresenter.new(print_size_with_associations)
    end
  end
end
