module Spree
  module Admin
    class FramePreviewImagesController < ::Spree::Admin::ResourceController
      before_action :load_edit_data, except: :index
      before_action :load_index_data, only: :index

      private

      def location_after_destroy
        admin_product_frame_preview_images_url(@product)
      end

      def location_after_save
        admin_product_frame_preview_images_url(@product)
      end

      def load_index_data
        @product = Product.friendly.preload(*variant_index_includes).find(params[:product_id])
      end

      def load_edit_data
        @product = Product.friendly.preload(*variant_edit_includes).find(params[:product_id])
        @variants = @product.variants.map do |variant|
          [variant.sku_and_options_text, variant.id]
        end
        @variants.insert(0, [Spree.t(:all), @product.master_id])
      end

      def variant_index_includes
        [
          variant_frame_preview_images: [variant: { option_values: :option_type }]
        ]
      end

      def variant_edit_includes
        [
          variants_including_master: { option_values: :option_type, frame_preview_images: :variant }
        ]
      end

      def model_class
        Frame::PreviewImage
      end
    end
  end
end
