class ListPresenter
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def to_json(*_args)
    items.map(&:to_json)
  end

  def to_h
    items.map(&:to_h)
  end

  class << self
    def empty
      new([])
    end
  end
end
