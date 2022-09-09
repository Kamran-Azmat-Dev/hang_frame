module Api
  class CustomFramesController < BaseController
    def show
      product = ::Spree::Product.active.friendly.find(params[:id])
      presenter = GetFrameDetails.new.call(product)

      render json: { product: presenter.to_h }, status: 200
    end

    def chevrons
      presenter = ::CustomFrame::GetAvailableChevrons.new.call
      render json: { chevrons: presenter.to_h }, status: 200
    end
  end
end
