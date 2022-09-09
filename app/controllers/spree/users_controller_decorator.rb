module Spree
  module UsersControllerDecorator
    def show
      @orders = @user.orders
                     .includes(*order_includes)
                     .complete
                     .order('completed_at desc')
    end

    private

    # rubocop:disable Metrics/MethodLength
    def order_includes
      [
        :bill_address,
        :ship_address,
        :payments,
        {
          line_items: [
            :hang_photo,
            {
              mount_color: {
                mount_preview_images: {
                  attachment_attachment: :blob
                }
              },
              variant: [
                :product,
                {
                  images: { attachment_attachment: :blob },
                  frame_preview_images: { attachment_attachment: :blob }
                }
              ]
            }
          ]
        }
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end

::Spree::UsersController.prepend(Spree::UsersControllerDecorator)
