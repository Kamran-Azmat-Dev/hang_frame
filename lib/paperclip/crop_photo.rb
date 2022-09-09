# frozen_string_literal: true

module Paperclip
  class CropPhoto < Paperclip::Thumbnail
    def transformation_command
      crop_command + super.join(' ').sub(/ -crop \S+/, '').split
    end

    def crop_command
      target = attachment.instance

      ['-crop', "#{target.width}x#{target.height}+#{target.left}+#{target.top}"]
    end
  end
end
