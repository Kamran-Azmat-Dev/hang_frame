module HangPhotoFinder
  extend ActiveSupport::Concern

  included do
    before_action :load_hang_photo
  end

  private

  def load_hang_photo
    @hang_photo = HangPhoto.find_by(uuid: cookies[:uploadUUID])
  end
end
