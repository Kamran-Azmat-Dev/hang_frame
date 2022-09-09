module Spree
  module OrderDecorator
    def self.prepended(base)
      base.money_methods :item_total_including_custom_frames
      base.enum original_art_packaging: %i[tube flat own_packaging]
      base.enum original_art_delivery: %i[home ups]
      # base.validates_presence_of :recepient_name, :recepient_message
    end

    # Finalizes an in progress order after checkout is complete.
    # Called after transition to complete state when payments will have been processed
    def finalize!
      # lock all adjustments (coupon promotions, etc.)
      all_adjustments.each(&:close)

      # update payment and shipment(s) states, and save
      updater.update_payment_state
      shipments.each do |shipment|
        shipment.update!(self)
        shipment.finalize!
      end

      updater.update_shipment_state
      save!
      updater.run_hooks

      touch :completed_at

      deliver_order_confirmation_email unless confirmation_delivered?
      deliver_shipped_email if shipped?

      deliver_store_owner_order_notification_email if deliver_store_owner_order_notification_email?

      deliver_donation_confirmation_email if donated?

      consider_risk
    end

    def deliver_donation_confirmation_email
      Spree::DonationMailer.confirm(order: self)
    end

    # "overridden" method item_count to prevent counting TreesForLife donation product
    def frames_line_items_count
      frame_line_items.sum(&:quantity)
    end

    def frame_line_items
      line_items.reject { |item| item.product.is_donation? && item.product.is_pickup? }
    end

    def donation_line_items
      line_items.select { |item| item.product.is_donation? }
    end

    def gift_wrapped_line_items
      line_items.select { |item| item.product.is_gift_wrapped? }
    end

    def pickup_line_items
      line_items.select { |item| item.product.is_pickup? }
    end

    def donated?
      line_items.find { |item| item.product.is_donation == true }.present?
    end
    
    def item_total_including_custom_frames
      line_item_adjustments.custom_frame.sum(&:amount)
    end
  end
end
::Spree::Order.prepend(Spree::OrderDecorator)
