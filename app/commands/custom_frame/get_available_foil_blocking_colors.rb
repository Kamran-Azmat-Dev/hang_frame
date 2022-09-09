module CustomFrame
  class GetAvailableFoilBlockingColors
    def call
      colors = CustomFrame::FoilBlockingColor.active
      presenters = colors.map { |e| CustomFrame::FoilBlockingColorPresenter.new(e) }
      ListPresenter.new(presenters)
    end
  end
end
