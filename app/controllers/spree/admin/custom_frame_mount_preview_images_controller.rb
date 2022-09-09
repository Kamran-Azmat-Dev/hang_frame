module Spree
  module Admin
    class CustomFrameMountPreviewImagesController < ::Spree::Admin::ResourceController
      before_action :load_edit_data, except: :index
      before_action :load_index_data, only: :index

      protected

      def location_after_destroy
        admin_custom_frame_mount_color_custom_frame_mount_preview_images_url(@mount_color)
      end

      def location_after_save
        admin_custom_frame_mount_color_custom_frame_mount_preview_images_url(@mount_color)
      end

      def load_index_data
        @mount_color = CustomFrame::MountColor.preload(:mount_preview_images)
                                              .find(params[:custom_frame_mount_color_id])
      end

      def load_edit_data
        @mount_color = CustomFrame::MountColor.preload(:mount_preview_images)
                                              .find(params[:custom_frame_mount_color_id])
      end

      def model_class
        CustomFrame::MountPreviewImage
      end
    end
  end
end
