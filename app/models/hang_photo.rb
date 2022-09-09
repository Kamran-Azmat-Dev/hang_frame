# frozen_string_literal: true

class HangPhoto < ApplicationRecord
  enum status: %w[uploaded preview_ready crop_ready error]
  enum hang_type: %w[standard custom original]

  belongs_to :original_art_type, class_name: 'OriginalArt::Type', optional: true

  alias_attribute :type, :hang_type

  has_attached_file :photo

  has_attached_file :preview_photo,
                    styles: { original: ['x0', :jpg] },
                    source_file_options: { all: '-auto-orient' }

  before_preview_photo_post_process :skip_for_jpeg_files

  has_attached_file :cropped_photo,
                    styles: { original: ['400x400>', :jpg] },
                    processors: [:crop_photo],
                    source_file_options: { all: '-auto-orient' }

  before_validation :generate_uuid

  validates :uuid, presence: true

  validates_attachment :photo,
                       presence: true,
                       content_type:
                         {
                           content_type: PHOTO_CONTENT_TYPE
                         },
                       size: { less_than_or_equal_to: 50.megabytes }

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid if uuid.nil?
  end

  def skip_for_jpeg_files
    return false if %w[image/jpg image/jpeg].include?(preview_photo_content_type)

    true
  end
end
