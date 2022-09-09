module OriginalArt
  class TypePresenter
    def initialize(original_art_type)
      @original_art_type = original_art_type
    end

    def to_h
      {
        id: original_art_type.id,
        name: original_art_type.name
      }
    end

    private

    attr_reader :original_art_type
  end
end
