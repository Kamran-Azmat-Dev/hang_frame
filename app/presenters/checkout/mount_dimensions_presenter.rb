module Checkout
  class MountDimensionsPresenter
    def initialize(mount_type_adjustment)
      @mount_type_adjustment = mount_type_adjustment
    end

    def to_h
      {
        'left' => mount_type_adjustment.mount_left,
        'top' => mount_type_adjustment.mount_top,
        'right' => mount_type_adjustment.mount_right,
        'bottom' => mount_type_adjustment.mount_bottom
      }
    end

    private

    attr_reader :mount_type_adjustment
  end
end
