module CustomFrame
  class CustomMountPreferencePresenter
    attr_reader :preference

    def initialize(preference)
      @preference = preference
    end

    def to_h
      {
        'minValue' => preference.min_value,
        'maxValue' => preference.max_value,
        'price' => preference.price.to_s
      }
    end
  end
end
