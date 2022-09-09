module Spree
  module Admin
    class WorksheetsController < ::Spree::Admin::ResourceController
      before_action :find_line_item, only: %i[show preview_frame]

      def show; end

      def preview_frame
        @presenter = ::Checkout::LineItemPresenter.new(@line_item)
      end
      
      private

      def model_class
        ::Spree::LineItem
      end

      def find_line_item
        @line_item = ::Spree::LineItem.find(params[:id])

        raise NotFoundError unless @line_item.frame?
      end
    end
  end
end
