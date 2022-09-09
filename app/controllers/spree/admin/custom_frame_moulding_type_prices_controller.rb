module Spree
  module Admin
    class CustomFrameMouldingTypePricesController < ::Spree::Admin::ResourceController
      before_action :load_moulding_types, only: %i[new edit]
      before_action :load_print_size

      private

      def load_moulding_types
        @moulding_types = CustomFrame::MouldingType.all.order(:id)
      end

      def load_print_size
        @print_size = CustomFrame::PrintSize.find(params[:custom_frame_print_size_id])
      end

      def location_after_destroy
        admin_custom_frame_print_size_custom_frame_moulding_type_prices_url(@print_size)
      end

      def location_after_save
        admin_custom_frame_print_size_custom_frame_moulding_type_prices_url(@print_size)
      end

      def model_class
        CustomFrame::MouldingTypePrice
      end
    end
  end
end
