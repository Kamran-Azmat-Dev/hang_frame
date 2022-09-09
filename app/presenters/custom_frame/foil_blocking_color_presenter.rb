module CustomFrame
  class FoilBlockingColorPresenter
    def initialize(foil_blocking_color)
      @foil_blocking_color = foil_blocking_color
    end

    def to_h
      {
        'id' => foil_blocking_color.id,
        'name' => foil_blocking_color.name,
        'display' => foil_blocking_color.display
      }
    end

    private

    attr_reader :foil_blocking_color
  end
end
