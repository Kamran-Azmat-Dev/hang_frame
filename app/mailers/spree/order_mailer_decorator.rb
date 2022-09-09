module Spree
  Spree::OrderMailer.class_eval do
    layout 'mailer'
    def confirm_email(order, resend = false)
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      current_store = @order.store
      subject = "Order Confirmation #{@order.number}"
      mail(to: @order.email, from: from_address, subject: subject, store_url: current_store.url)
    end
  end
end
