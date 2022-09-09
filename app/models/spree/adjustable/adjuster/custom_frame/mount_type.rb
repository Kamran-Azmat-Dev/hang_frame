module Spree
  module Adjustable
    module Adjuster
      module CustomFrame
        class MountType < Spree::Adjustable::Adjuster::Base
          def update
            totals = [
              adjustments.custom_mount_type.pluck(:amount).sum,
              adjustments.custom_mount_option.pluck(:amount).sum,
              adjustments.custom_mount_additionals.pluck(:amount).sum,
              adjustments.custom_moulding_type_prices.pluck(:amount).sum
            ].sum

            update_totals(total: totals)
          end

          private

          def update_totals(total:)
            @totals[:taxable_adjustment_total] = total
          end
        end
      end
    end
  end
end
