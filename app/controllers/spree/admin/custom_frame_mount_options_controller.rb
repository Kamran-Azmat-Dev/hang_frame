module Spree
  module Admin
    class CustomFrameMountOptionsController < ::Spree::Admin::ResourceController
      protected

      def model_class
        CustomFrame::MountOption
      end
    end
  end
end
