module CustomFrame
  class MountTypePresenter
    attr_reader :mount_type

    def initialize(mount_type)
      @mount_type = mount_type
    end

    def preferences_presenter
      preferences_presenters = mount_type.preferences.map { |e| CustomFrame::CustomMountPreferencePresenter.new(e) }
      ListPresenter.new(preferences_presenters)
    end

    def to_h
      {
        id: mount_type.id,
        value: mount_type.name,
        label: mount_type.label,
        price: mount_type.price,
        preferences: preferences_presenter.to_h
      }
    end
  end
end
