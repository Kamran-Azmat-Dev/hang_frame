module Spree
  module V2
    module Storefront
      class AdjustmentSerializer < BaseSerializer
        set_type :adjustment

        attributes :source_type, :source_id, :notes, :mount_top, :mount_bottom, :mount_left, :mount_right
      end
    end
  end
end
