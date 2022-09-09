module Spree
  module ProductsControllerDecorator
    def show
      super
      @details_presenter = GetFrameDetails.new.call(@product)
      @foil_blocking_colors_presenter = CustomFrame::GetAvailableFoilBlockingColors.new.call
      @mount_colors_presenter = CustomFrame::GetAvailableMountColors.new.call
    end

    private

    def load_product
      @products = if try_spree_current_user.try(:has_spree_role?, 'admin')
                    Product.with_deleted
                  else
                    Product.active(current_currency)
                  end

      eager_load_associations = [
        master: [:prices],
        active_variants: [
          :prices,
          {
            images: { attachment_attachment: :blob },
            option_values: %i[option_value_variants option_type],
            frame_preview_images: { attachment_attachment: :blob }
          }
        ]
      ]

      @product = @products.includes(*eager_load_associations)
                          .friendly
                          .find(params[:id])
    end
  end
end

::Spree::ProductsController.prepend(Spree::ProductsControllerDecorator)
