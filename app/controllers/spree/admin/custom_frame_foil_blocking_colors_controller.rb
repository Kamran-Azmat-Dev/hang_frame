module Spree
  module Admin
    class CustomFrameFoilBlockingColorsController < ::Spree::Admin::ResourceController
      protected

      def model_class
        CustomFrame::FoilBlockingColor
      end
    end
  end
end
