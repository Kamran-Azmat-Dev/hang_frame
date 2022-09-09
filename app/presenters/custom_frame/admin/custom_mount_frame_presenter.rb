module CustomFrame
    module Admin
      class CustomMountFramePresenter
        def initialize(collection:)
          @collection = collection
        end
  
        def to_json(*_args)
          collection.map do |item|
            {
              id: item.id,
              name: item.formatted_label
            }
          end
        end
  
        private
  
        attr_reader :collection
      end
    end
  end
  