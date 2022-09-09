module Spree
  module Admin
    class CustomFrameAdditionalsController < ::Spree::Admin::ResourceController
      protected

      def model_class
        CustomFrame::Additional
      end
    end
  end
end
