module Spree
  module HomeControllerDecorator
    def index
      redirect_to digital_upload_path
    end
  end
end

::Spree::HomeController.prepend(Spree::HomeControllerDecorator)
