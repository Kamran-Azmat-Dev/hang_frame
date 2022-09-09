class GetFramePreviewViewbox
  DEFAULT_VIEWBOX = FramePreviewViewbox.new(0, 0, 0, 0).freeze
  VIEWBOX_SCALE = 1000

  def call(image)
    return DEFAULT_VIEWBOX unless validate_image_attachment?(image)

    image_metadata = image.attachment.metadata
    width = image_metadata['width']
    height = image_metadata['height']

    return DEFAULT_VIEWBOX unless validate_image_dimensions?(width, height)
    return DEFAULT_VIEWBOX unless validate_preview_position?(image)

    preview_width = image.preview_position_right - image.preview_position_left
    preview_height = image.preview_position_bottom - image.preview_position_top

    FramePreviewViewbox.new(
      compute_viewbox_x(image, width),
      compute_viewbox_y(image, height),
      compute_viewbox_width(width, preview_width),
      compute_viewbox_height(height, preview_height)
    )
  end

  private

  def validate_image_attachment?(image)
    image.present? && image.attachment.present? && image.attachment.metadata.present?
  end

  def validate_image_dimensions?(width, height)
    width.present? && width.positive? && height.present? && height.positive?
  end

  def validate_preview_position?(image)
    validate_preview_position_element?(image.preview_position_left) &&
      validate_preview_position_element?(image.preview_position_right) &&
      validate_preview_position_element?(image.preview_position_top) &&
      validate_preview_position_element?(image.preview_position_bottom)
  end

  def validate_preview_position_element?(element)
    element.present? && element.positive?
  end

  def compute_viewbox_x(image, width)
    (image.preview_position_left.to_d / width * VIEWBOX_SCALE).round
  end

  def compute_viewbox_y(image, height)
    (image.preview_position_top.to_d / height * VIEWBOX_SCALE).round
  end

  def compute_viewbox_width(width, preview_width)
    (preview_width.to_d / width * VIEWBOX_SCALE).round
  end

  def compute_viewbox_height(height, preview_height)
    (preview_height.to_d / height * VIEWBOX_SCALE).round
  end
end
