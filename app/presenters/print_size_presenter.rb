class PrintSizePresenter
  CM_TO_INCH = 0.393701

  attr_reader :option_value_id, :width, :height

  def initialize(option_value_id, width, height)
    @option_value_id = option_value_id
    @width = width
    @height = height
  end

  def width_inches
    width.to_d * CM_TO_INCH
  end

  def height_inches
    height.to_d * CM_TO_INCH
  end

  def to_json(*_args)
    {
      'optionValueId' => option_value_id,
      width: width.to_s,
      height: height.to_s,
      width_inches: width_inches.to_s,
      height_inches: height_inches.to_s
    }
  end
end
