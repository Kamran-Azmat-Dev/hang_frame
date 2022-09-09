module Spree
  module Cart
    module CustomFrame
      # rubocop:disable Metrics/ClassLength
      class CreateAdjustments
        prepend Spree::ServiceModule::Base

        # rubocop:disable Lint/UnusedMethodArgument
        def call(line_item:, payload: {})
          run :validate
          run :add_moulding_type_adjustment
          run :add_mount_type_adjustment
          run :add_mount_option_adjustment
          run :add_foil_blocking_adjustment
          run :add_mount_additionals_adjustments
        end
        # rubocop:enable Lint/UnusedMethodArgument

        private

        def validate(line_item:, payload: {})
          return failure(line_item: line_item, payload: payload) unless line_item.print_size.present?
          return failure(line_item: line_item, payload: payload) if payload.empty?

          success(line_item: line_item, payload: payload)
        end

        def add_moulding_type_adjustment(line_item:, payload: {})
          
          product = line_item.product
          return unless product.custom? || product.taxons.map(&:name).include?('Personalized')

          hang_photo = line_item.hang_photo
          print_size = ::CustomFrame::CustomerPrintSizeQuery.new.call(hang_photo.print_width, hang_photo.print_height)
          moulding_type = product.moulding_type

          moulding_type_price = print_size.moulding_type_prices.find_by(moulding_type: moulding_type)
          return failure(line_item: line_item, payload: payload) unless moulding_type_price.present?
          line_item.adjustments.new(
            payload_values(resource: moulding_type_price, line_item: line_item)
          ).save!

          success(line_item: line_item, payload: payload)
        end

        def add_mount_type_adjustment(line_item:, payload: {})
          
          mount_type = line_item.print_size.mount_types.find(payload['mount_type_id'])
          mount_dimensions = payload['mount_dimensions']

          price = price_for_mount_type(mount_type, mount_dimensions)
          return failure(line_item: line_item, payload: payload) unless price.present?

          line_item.adjustments.new(
            payload_values_for_mount_type(mount_type: mount_type,
                                          mount_dimensions: mount_dimensions,
                                          price: price,
                                          line_item: line_item)
          ).save!

          success(line_item: line_item, payload: payload)
        end

        def add_mount_option_adjustment(line_item:, payload: {})
          
          mount_option = line_item.print_size.mount_options.find(payload['mount_option_id'])

          line_item.adjustments.new(
            payload_values(resource: mount_option, line_item: line_item)
          ).save!

          success(line_item: line_item, payload: payload)
        end

        def add_foil_blocking_adjustment(line_item:, payload: {})
          
          foil_blocking_payload = payload['foil_blocking']
          if foil_blocking_payload
            additional = line_item.print_size.additionals.find(foil_blocking_payload['additional_id'])

            configuration = JSON.dump(foil_blocking_payload.permit(:line1, :line2,
                                                                   color: %i[id name display]).to_h)
            notes = "foil_blocking #{configuration}"
            adjustment_params = payload_values(resource: additional, line_item: line_item)
                                .merge(notes: notes)

            line_item.adjustments.new(adjustment_params).save!
          end

          success(line_item: line_item, payload: payload)
        end

        def add_mount_additionals_adjustments(line_item:, payload: {})
          
          additionals = line_item.print_size.additionals.where(id: payload['additionals'])

          additionals.each do |additional|
            adjustment_params = payload_values(resource: additional, line_item: line_item)
                                .merge(notes: 'linen')

            line_item.adjustments.new(adjustment_params).save!
          end

          success(line_item: line_item, payload: payload)
        end

        def payload_values(resource:, line_item:)
          {
            source: resource,
            amount: resource.price,
            included: true,
            label: formatted_label(resource),
            order: line_item.order
          }
        end

        def payload_values_for_mount_type(mount_type:, mount_dimensions:, price:, line_item:)
          {
            source: mount_type,
            amount: price,
            included: true,
            label: formatted_label(mount_type),
            order: line_item.order,
            mount_top: mount_dimensions['top'].to_d,
            mount_left: mount_dimensions['left'].to_d,
            mount_right: mount_dimensions['right'].to_d,
            mount_bottom: mount_dimensions['bottom'].to_d
          }
        end

        def formatted_label(resource)
          resource.class.name.split('::').last
        end

        def find_matching_preference(mount_type, mount_dimensions)
          combined_mount_dimensions = mount_dimensions['top'].to_d +
                                      mount_dimensions['left'].to_d
                                      mount_dimensions['right'].to_d
                                      mount_dimensions['bottom'].to_d

          mount_type.preferences.find do |e|
            e.min_value <= combined_mount_dimensions && combined_mount_dimensions <= e.max_value
          end
        end

        def price_for_mount_type(mount_type, mount_dimensions)
          if mount_type.preferences.any?
            matching_preference = find_matching_preference(mount_type, mount_dimensions)
            return nil unless matching_preference.present?

            matching_preference.price
          else
            mount_type.price
          end
        end
      end
      # rubocop:enable Metrics/ClassLength
    end
  end
end
