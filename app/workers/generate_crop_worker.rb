class GenerateCropWorker
  include Sidekiq::Worker

  def perform(hang_photo_id)
    hang_photo = HangPhoto.find(hang_photo_id)
    Upload::GenerateCrop.new.call(hang_photo)
  end
end
