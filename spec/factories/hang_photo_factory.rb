# frozen_string_literal: true

FactoryBot.define do
  factory :hang_photo, class: HangPhoto do
    uuid { SecureRandom.uuid }
    photo { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/image.jpg") }
    preview_photo { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/image.jpg") }
  end
end
