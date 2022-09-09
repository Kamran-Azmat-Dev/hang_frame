class HangPhotoPresenter
  attr_reader :hang_photo

  delegate :print_width, :print_height, :hang_type, :print_size_option_value_id, to: :hang_photo

  def initialize(hang_photo)
    @hang_photo = hang_photo
  end

  def photo_url
    return nil unless hang_photo.preview_photo.present?

    hang_photo.preview_photo.url
  end

  def cropped_photo_url
    return nil unless hang_photo.cropped_photo.present?

    hang_photo.cropped_photo.url
  end

  def moulding_type_price_presenters
    return ListPresenter.empty unless hang_photo.print_width && hang_photo.print_height
    return ListPresenter.empty if hang_photo.standard?

    print_size = CustomFrame::CustomerPrintSizeQuery.new.call(hang_photo.print_width, hang_photo.print_height)
    return ListPresenter.empty unless print_size.present?

    moulding_type_prices = print_size.moulding_type_prices
    presenters = moulding_type_prices.map { |e| CustomFrame::MouldingTypePricePresenter.new(e) }

    ListPresenter.new(presenters)
  end

  def custom?
    hang_photo.hang_type.present? && !hang_photo.standard?
  end

  def to_h
    {
      'uuid' => hang_photo.uuid,
      'status' => hang_photo.status,
      'photoUrl' => photo_url,
      'croppedPhotoUrl' => cropped_photo_url,
      'hangType' => hang_type,
      'isCustom' => custom?,
      'printWidth' => print_width,
      'printHeight' => print_height,
      'printSizeOptionValueId' => print_size_option_value_id,
      'mouldingTypePrices' => moulding_type_price_presenters.to_h
    }
  end
end
