module StandardFrame
  class GetAvailableChevrons
    def call(print_size_id)
      product_ids = Spree::Product.group('spree_products.id')
                                  .joins(variants_including_master: :option_values)
                                  .where(spree_option_values: { id: print_size_id })
                                  .ids
                                  .uniq.compact

      products = Spree::Product.active
                               .includes(variants: {
                                           frame_preview_images: { attachment_attachment: :blob }
                                         })
                               .where(id: product_ids)
                               .order(available_on: :desc)

      presenters = products.map { |e| CustomFrame::ChevronPresenter.new(e) }
      presenters = presenters.select { |e| e.chevron_image_url.present? }

      ListPresenter.new(presenters)
    end
  end
end
