module Frame
  class ColorPresenter
    attr_reader :name, :value

    def initialize(name, value)
      @name = name
      @value = value
    end

    def to_json(*_args)
      {
        name: name,
        value: value,
        id: value
      }
    end
  end
end
