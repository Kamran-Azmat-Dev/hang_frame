module CustomFrame
  class MountOptionPresenter
    attr_reader :mount_option

    def initialize(mount_option)
      @mount_option = mount_option
    end

    def to_h
      {
        id: mount_option.id,
        value: mount_option.name,
        icon: mount_option.name,
        label: mount_option.label,
        top: mount_option.top.to_s,
        bottom: mount_option.bottom.to_s,
        left: mount_option.left.to_s,
        right: mount_option.right.to_s,
        price: mount_option.price.to_s
      }
    end
  end
end
