module Spree
  module Cart
    class AddItem
      prepend Spree::ServiceModule::Base

      # rubocop:disable Lint/UnusedMethodArgument
      def call(order:, variant:, quantity: nil, options: {})
        
        ApplicationRecord.transaction do
          run :add_to_line_item
          run :add_custom_frame_adjustments
          run :update_custom_line_item_price
          run Spree::Dependencies.cart_recalculate_service.constantize
        end
      end
      # rubocop:enable Lint/UnusedMethodArgument

      private

      # rubocop:disable Lint/UnusedMethodArgument
      def update_custom_line_item_price(order:, line_item:, line_item_created:, options: {})
        line_item.update(price: line_item.pre_tax_amount) if line_item.custom? || line_item.original_art?
        if options['foil_blocking'].present?
          # line_item.update(price: line_item.taxable_adjustment_total) if line_item.custom? || line_item.original_art?
         line_item.update(price: line_item.pre_tax_amount) if line_item.custom? || line_item.original_art?
        end

        order.updater.update_item_total

        success(order: order, line_item: line_item, line_item_created: true, options: options)
      end
      # rubocop:enable Lint/UnusedMethodArgument

      def add_custom_frame_adjustments(order:, line_item:, line_item_created:, options: {})
        Spree::Cart::CustomFrame::CreateAdjustments.call(line_item: line_item, payload: options)

        ::Spree::TaxRate.adjust(order, [line_item]) if line_item_created
        success(order: order, line_item: line_item, line_item_created: line_item_created, options: options)
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      # rubocop:disable Metrics/PerceivedComplexity
      def add_to_line_item(order:, variant:, quantity: nil, options: {})
        options ||= {}
        quantity ||= 1

        line_item = Spree::Dependencies.line_item_by_variant_finder.constantize.new.execute(order: order,
                                                                                            variant: variant,
                                                                                            options: options)

        if line_item.present? && line_item.product.is_donation?
          line_item.quantity += quantity.to_i
        elsif line_item.present? && line_item.product.is_pickup
          return failure(order) unless line_item.present?
        else
          line_item = build_line_item(order, variant, quantity, options)
        end

        line_item.target_shipment = options[:shipment] if options.key? :shipment

        return failure(line_item) unless line_item.save

        line_item.reload.update_price
        
        if line_item.product.custom?
          line_item.reload.update_price
        else
          if options.include?("foil_blocking")
            line_item.update(foil_blocking: true)
            line_item.update(price: line_item.reload.update_price)
          end
        end

        success(order: order, line_item: line_item, line_item_created: true, options: options)
      end
      # rubocop:enable Metrics/PerceivedComplexity
      # rubocop:enable Metrics/CyclomaticComplexity

      def build_line_item(order, variant, quantity, options)
        
        # rubocop:disable Style/MultilineBlockChain
        opts = ::Spree::PermittedAttributes.line_item_attributes.flatten.each_with_object({}) do |attribute, result|
          result[attribute] = options[attribute]
        end.merge(currency: order.currency).delete_if { |_key, value| value.nil? }
        # rubocop:enable Style/MultilineBlockChain

        hang_photo = find_hang_photo(options)
        mount_color = find_mount_color(options)
        accent_mount_color = find_accent_mount_color(options)

        order.line_items.new(
          quantity: quantity,
          variant: variant,
          hang_photo: hang_photo,
          mount_color: mount_color,
          accent_mount_color: accent_mount_color,
          options: opts
        )
      end

      def find_hang_photo(options)
        
        uuid = options[:hang_photo_uuid]
        return nil if uuid.nil?

        ::HangPhoto.find_by!(uuid: uuid)
      end

      def find_mount_color(options)
        
        id = options[:mount_color_id]
        return nil if id.nil?

        ::CustomFrame::MountColor.find(id)
      end

      def find_accent_mount_color(options)
        
        id = options[:accent_mount_color_id]
        return nil if id.nil?

        ::CustomFrame::MountColor.find(id)
      end
    end
  end
end
