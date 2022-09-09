module Spree
  class FramesController < Spree::StoreController
    include Spree::CacheHelper

    respond_to :html

    def index
      @standard_frames = ::Spree::Product.where(featured: true, custom: false).order(available_on: :desc).limit(4)
      @custom_frames = ::Spree::Product.where(featured: true, custom: true).order(available_on: :desc).limit(4)

      fresh_when(etag: store_etag, last_modified: store_last_modified, public: true) if http_cache_enabled?
    end
  end
end
