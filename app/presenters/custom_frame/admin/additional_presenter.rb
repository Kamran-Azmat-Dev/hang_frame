module CustomFrame
  module Admin
    class AdditionalPresenter
      def initialize(collection:)
        @collection = collection
      end

      def to_json(*_args)
        collection.map do |item|
          {
            id: item.id,
            name: item.name
          }
        end
      end

      private

      attr_reader :collection
    end
  end
end
