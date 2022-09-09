module CustomFrame
  class GetAvailableChevrons
    def call
      products = Spree::Product.active
                               .includes(variants: {
                                           frame_preview_images: { attachment_attachment: :blob }
                                         })
                               .where(custom: true)
                               .order(available_on: :desc)

      presenters = products.map { |e| CustomFrame::ChevronPresenter.new(e) }
      presenters = presenters.select { |e| e.chevron_image_url.present? }

      ListPresenter.new(presenters)
    end
  end
end
