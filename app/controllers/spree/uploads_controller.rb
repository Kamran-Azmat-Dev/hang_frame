module Spree
  class UploadsController < Spree::StoreController
    include Spree::CacheHelper

    respond_to :html

    def digital
      @standard_print_sizes = GetStandardPrintSizes.new.call
      fresh_when(etag: store_etag, last_modified: store_last_modified, public: true) if http_cache_enabled?
    end

    def original_art
      @original_art_types_presenter = OriginalArt::GetTypes.new.call
      fresh_when(etag: store_etag, last_modified: store_last_modified, public: true) if http_cache_enabled?
    end
  end
end
