module Spree
  class NewslettersController < Spree::StoreController
    skip_before_action :verify_authenticity_token
    respond_to :html

    def create
      AddToMailingList.new.call(email: params['email'])
    end
  end
end
