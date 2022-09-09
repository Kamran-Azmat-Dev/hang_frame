module Spree
  module V2
    module Storefront
      class MountPreviewImageSerializer < BaseSerializer
        attributes :name, :width, :height

        attribute :pattern do |object|
          Rails.application.routes.url_helpers.url_for(object.attachment)
        end
      end
    end
  end
end
