module CustomFrame
  class GetAvailableMountColors
    def call
      colors = CustomFrame::MountColor.includes(mount_preview_images: { attachment_attachment: :blob }).active
      presenters = colors.map { |e| CustomFrame::MountColorPresenter.new(e) }
      ListPresenter.new(presenters)
    end
  end
end
