module Spree
  module Admin
    class OriginalArtTypesController < ::Spree::Admin::ResourceController
      private

      def model_class
        OriginalArt::Type
      end
    end
  end
end
