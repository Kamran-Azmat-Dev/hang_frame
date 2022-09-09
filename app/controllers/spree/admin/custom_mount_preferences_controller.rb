module Spree
  module Admin
    class CustomMountPreferencesController < ::Spree::Admin::ResourceController
      def location_after_save
        admin_custom_mount_preferences_path
      end

      protected

      def model_class
        CustomFrame::CustomMountPreference
      end

      def collection_url(*)
        admin_custom_mount_preferences_url
      end

      def permitted_resource_params
        if params["custom_frame_#{resource.object_name}"].present?
          params.require("custom_frame_#{resource.object_name}").permit!
        else
          ActionController::Parameters.new
        end
      end
    end
  end
end
