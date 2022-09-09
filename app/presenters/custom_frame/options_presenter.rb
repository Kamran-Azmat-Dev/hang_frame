module CustomFrame
  class OptionsPresenter
    attr_reader :print_size

    def initialize(print_size)
      @print_size = print_size
    end

    def mount_types_presenter
      presenters = print_size.mount_types.map { |e| CustomFrame::MountTypePresenter.new(e) }
      ListPresenter.new(presenters)
    end

    def mount_options_presenter
      presenters = print_size.mount_options.map { |e| CustomFrame::MountOptionPresenter.new(e) }
      ListPresenter.new(presenters)
    end

    def additionals_presenter
      presenters = print_size.additionals.map { |e| CustomFrame::AdditionalPresenter.new(e) }
      ListPresenter.new(presenters)
    end

    def moulding_type_prices_presenter
      presenters = print_size.moulding_type_prices.map { |e| CustomFrame::MouldingTypePricePresenter.new(e) }
      ListPresenter.new(presenters)
    end

    def to_h
      {
        'printSizeId' => print_size.id,
        'mouldingTypePrices' => moulding_type_prices_presenter.to_h,
        'mountTypes' => mount_types_presenter.to_h,
        'mountOptions' => mount_options_presenter.to_h,
        'additionals' => additionals_presenter.to_h
      }
    end
  end
end
