module OriginalArt
  class GetTypes
    def initialize
      @art_types = OriginalArt::Type.active.order(:id)
    end

    def call
      ListPresenter.new(original_art_type_presenters)
    end

    private

    attr_reader :art_types

    def original_art_type_presenters
      art_types.map { |e| OriginalArt::TypePresenter.new(e) }
    end
  end
end
