# frozen_string_literal: true

class HangPhotoValidator < Dry::Validation::Contract
  params do
    required(:photo).value(type?: ActionDispatch::Http::UploadedFile)
  end
end
