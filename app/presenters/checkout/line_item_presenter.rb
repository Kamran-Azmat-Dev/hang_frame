module Checkout
  class LineItemPresenter
    def initialize(line_item)
      @line_item = line_item
    end

    def custom?
      line_item.product.custom?
    end

    def gift?
      if line_item.hang_photo.present?
        line_item.product.is_gift_wrapped
      end
    end

    def pickup?
      line_item.product.is_pickup
    end

    def upload_presenter
      if line_item.hang_photo.present?
        Checkout::UploadPresenter.new(line_item.hang_photo)
      end
    end

    def mount_color_presenter
      mount_color = line_item.mount_color
      return nil unless mount_color.present?

      CustomFrame::MountColorPresenter.new(mount_color)
    end

    def accent_mount_color_presenter
      accent_mount_color = line_item.accent_mount_color
      return nil unless accent_mount_color.present?

      CustomFrame::MountColorPresenter.new(accent_mount_color)
    end

    def variant_presenter
      Frame::FrameVariantPresenter.new(line_item.variant)
    end

    def preview_configuration_presenter
      Checkout::PreviewConfigurationPresenter.new(variant_presenter,
                                                  mount_color_presenter,
                                                  accent_mount_color_presenter,
                                                  line_item.linen_adjustment.present?)
    end

    def mount_dimensions_presenter
      mount_type_adjustment = line_item.adjustments.find { |e| e.source_type == 'CustomFrame::MountType' }

      Checkout::MountDimensionsPresenter.new(mount_type_adjustment)
    end

    private

    attr_reader :line_item
  end
end
