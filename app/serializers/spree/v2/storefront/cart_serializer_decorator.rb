# frozen_string_literal: true

module Spree
  module V2
    module Storefront
      module CartSerializerDecorator
        def self.prepended(base)
          base.attribute :frames_line_items_count
        end
      end
    end
  end
end
::Spree::V2::Storefront::CartSerializer.prepend(Spree::V2::Storefront::CartSerializerDecorator)
