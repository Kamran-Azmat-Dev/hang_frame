module Spree
  module Admin
    class CustomFrameMouldingTypesController < ::Spree::Admin::ResourceController
      private

      def model_class
        CustomFrame::MouldingType
      end

      def location_after_destroy
        admin_custom_frame_moulding_types_url
      end

      def location_after_save
        admin_custom_frame_moulding_types_url
      end
    end
  end
end
