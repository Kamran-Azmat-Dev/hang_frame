module Spree
  module Admin
    class CustomFrameMountColorsController < ::Spree::Admin::ResourceController
      private

      def model_class
        CustomFrame::MountColor
      end

      def location_after_destroy
        admin_custom_frame_mount_colors_url
      end

      def location_after_save
        admin_custom_frame_mount_colors_url
      end
    end
  end
end
