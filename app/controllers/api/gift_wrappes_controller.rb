module Api
    class GiftWrappesController < BaseController
        def update_name_and_message
            Spree::Order.find(params[:order_id]).update(recepient_name: params[:gift_wrappe][:name], recepient_message: params[:gift_wrappe][:message])
        end
        def add_original_art_packaging
           Spree::Order.find(params[:order_id]).update(package_option: params[:gift_wrappe][:option])
        end
    end
end
