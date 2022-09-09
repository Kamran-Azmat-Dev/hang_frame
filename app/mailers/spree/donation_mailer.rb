module Spree
  class DonationMailer < ::Spree::BaseMailer
    def confirm(order:)
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      current_store = @order.store
      subject = 'Change me'

      mail(to: @order.email, from: from_address, subject: subject, store_url: current_store.url)
    end
  end
end
