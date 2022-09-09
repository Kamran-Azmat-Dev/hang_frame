module Spree
  module Admin
    class CustomFrameMountTypesController < ::Spree::Admin::ResourceController
      protected

      def model_class
        CustomFrame::MountType
      end
    end
  end
end
