module CustomFrame
  class MountColorPresenter
    include Rails.application.routes.url_helpers

    attr_reader :mount_color, :mount_pattern, :mount_border_top_left, :mount_border_bottom_right

    def initialize(mount_color)
      @mount_color = mount_color

      mount_preview_images = mount_color.mount_preview_images
      @mount_pattern = mount_preview_images.find { |e| e.name == CustomFrame::MountPreviewImage::MOUNT_PATTERN }
      @mount_border_top_left = mount_preview_images.find do |e|
        e.name == CustomFrame::MountPreviewImage::MOUNT_BORDER_TOP_LEFT
      end
      @mount_border_bottom_right = mount_preview_images.find do |e|
        e.name == CustomFrame::MountPreviewImage::MOUNT_BORDER_BOTTOM_RIGHT
      end
    end

    def mount_pattern_url
      return nil if mount_pattern.nil?

      url_for(mount_pattern.attachment)
    end

    def mount_pattern_width
      return nil if mount_pattern.nil?

      mount_pattern.width
    end

    def mount_pattern_height
      return nil if mount_pattern.nil?

      mount_pattern.height
    end

    def mount_border_top_left_url
      return nil if mount_border_top_left.nil?

      url_for(mount_border_top_left.attachment)
    end

    def mount_border_top_left_width
      return nil if mount_border_top_left.nil?

      mount_border_top_left.width
    end

    def mount_border_top_left_height
      return nil if mount_border_top_left.nil?

      mount_border_top_left.height
    end

    def mount_border_bottom_right_url
      return nil if mount_border_bottom_right.nil?

      url_for(mount_border_bottom_right.attachment)
    end

    def mount_border_bottom_right_width
      return nil if mount_border_bottom_right.nil?

      mount_border_bottom_right.width
    end

    def mount_border_bottom_right_height
      return nil if mount_border_bottom_right.nil?

      mount_border_bottom_right.height
    end

    def to_json(*_args)
      {
        'id' => mount_color.id,
        'value' => mount_color.presentation,
        'name' => mount_color.name,
        'isLinen' => mount_color.linen?,
        'allowFloatMount' => mount_color.allow_float_mount?,
        'mountPattern' => mount_pattern_hash,
        'mountBorderTopLeft' => mount_border_top_left_hash,
        'mountBorderBottomRight' => mount_border_bottom_right_hash
      }
    end

    def mount_pattern_hash
      {
        'mountPattern' => mount_pattern_url,
        'mountPatternWidth' => mount_pattern_width,
        'mountPatternHeight' => mount_pattern_height
      }
    end

    def mount_border_top_left_hash
      {
        'mountBorderTopLeft' => mount_border_top_left_url,
        'mountBorderTopLeftWidth' => mount_border_top_left_width,
        'mountBorderTopLeftHeight' => mount_border_top_left_height
      }
    end

    def mount_border_bottom_right_hash
      {
        'mountBorderBottomRight' => mount_border_bottom_right_url,
        'mountBorderBottomRightWidth' => mount_border_bottom_right_width,
        'mountBorderBottomRightHeight' => mount_border_bottom_right_height
      }
    end

    def to_h
      to_json
    end
  end
end
