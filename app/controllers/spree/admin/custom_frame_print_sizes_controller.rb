module Spree
  module Admin
    class CustomFramePrintSizesController < ::Spree::Admin::ResourceController
      before_action :cleanup_nested_params, on: %i[create update], if: -> { params['custom_frame_print_size'].present? }

      private

      # rubocop:disable Layout/LineLength
      def clean_mount_type_params
        params['custom_frame_print_size']['mount_type_ids'] = params['custom_frame_print_size']['mount_type_ids'].reject(&:empty?)
      end

      def clean_mount_option_params
        params['custom_frame_print_size']['mount_option_ids'] = params['custom_frame_print_size']['mount_option_ids'].reject(&:empty?)
      end

      def clean_additional_params
        params['custom_frame_print_size']['additional_ids'] = params['custom_frame_print_size']['additional_ids'].reject(&:empty?)
      end
      # rubocop:enable Layout/LineLength

      def cleanup_nested_params
        clean_mount_type_params if params['custom_frame_print_size']['mount_type_ids'].present?
        clean_mount_option_params if params['custom_frame_print_size']['mount_option_ids'].present?
        clean_additional_params if params['custom_frame_print_size']['additional_ids'].present?
      end

      protected

      def model_class
        CustomFrame::PrintSize
      end
    end
  end
end
