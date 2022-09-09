module CustomFrame
    class CustomMountFramePresenter
      attr_reader :custom_mount_frame
  
      def initialize(custom_mount_frame)
        @custom_mount_frame = custom_mount_frame
      end
  
      def preferences_presenter
        preferences_presenters = custom_mount_frame.preferences.map { |e| CustomFrame::CustomMountPreferencePresenter.new(e) }
        ListPresenter.new(preferences_presenters)
      end
  
      def to_h
        {
          id: custom_mount_frame.id,
          value: custom_mount_frame.name,
          label: custom_mount_frame.label,
          price: custom_mount_frame.price,
          preferences: preferences_presenter.to_h
        }
      end
    end
  end
  