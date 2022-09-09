module CustomFrame
  class AdditionalPresenter
    attr_reader :additional

    def initialize(additional)
      @additional = additional
    end

    def to_h
      {
        id: additional.id,
        name: additional.name,
        price: additional.price.to_s
      }
    end
  end
end
