module Checkout
  class PreviewConfigurationPresenter
    def initialize(variant_presenter, mount_color_presenter, accent_mount_color_presenter, linen_mount_chosen)
      @variant_presenter = variant_presenter
      @mount_color_presenter = mount_color_presenter
      @accent_mount_color_presenter = accent_mount_color_presenter
      @linen_mount_chosen = linen_mount_chosen
    end

    def to_h
      result = variant_presenter.to_h['framePreviewConfiguration']

      result = result.merge(mount_pattern_options) if mount_color_presenter.present?

      if accent_mount_color_presenter.present?
        result = result.merge('accentMount' => accent_mount_color_presenter.to_h['mountPattern'])
      end

      result
    end

    private

    attr_reader :variant_presenter, :mount_color_presenter, :accent_mount_color_presenter, :linen_mount_chosen

    def mount_pattern_options
      mount_color_hash = mount_color_presenter.to_h
      mount_color_hash['mountPattern']
    end
  end
end
