class GetStandardPrintSizes
  def initialize
    @option_type = Spree::OptionType.find_by(name: Frame::Constants::PRINT_SIZE_OPTION_TYPE)
  end

  def call
    return ListPresenter.empty unless option_type.present?

    print_size_presenters = option_type.option_values.map do |value|
      build_print_size_presenter(value)
    end.compact

    ListPresenter.new(print_size_presenters)
  end

  private

  attr_reader :option_type

  def build_print_size_presenter(option_value)
    width, height = option_value.name.split('x')
    return nil if width.nil? || height.nil?

    PrintSizePresenter.new(option_value.id, width.to_d, height.to_d)
  end
end
