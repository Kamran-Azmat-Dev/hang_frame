# frozen_string_literal: true

class CropDetailsValidator < Dry::Validation::Contract
  params do
    required(:width).filled(:integer)
    required(:height).filled(:integer)
    required(:left).filled(:integer)
    required(:top).filled(:integer)
    required(:type).filled(:string)
    required(:print_width).filled(:string)
    required(:print_height).filled(:string)
    optional(:print_size_option_value_id).filled(:integer)
    optional(:original_art_type_id).filled(:integer)
  end

  rule(:type) do
    key.failure('please choose: [standard/custom] type') unless HangPhoto.hang_types.include?(values[:type])
  end

  rule(:width) do
    key.failure('value can\'t be negative') if values[:width].negative?
  end

  rule(:height) do
    key.failure('value can\'t be negative') if values[:height].negative?
  end

  rule(:left) do
    key.failure('value can\'t be negative') if values[:left].negative?
  end

  rule(:top) do
    key.failure('value can\'t be negative') if values[:top].negative?
  end
end
