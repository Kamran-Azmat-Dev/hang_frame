# frozen_string_literal: true

class PhotoValidator < Dry::Validation::Contract
  params do
    required(:uuid).filled(:string)
  end
end
