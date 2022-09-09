module Spree
  module HangframingFrontendHelper
    def hangframing_flash_messages(opts = {})
      flashes = ''
      excluded_types = opts[:excluded_types].to_a.map(&:to_s)

      flash.to_h.except('order_completed').each do |msg_type, text|
        next if msg_type.blank? || excluded_types.include?(msg_type)

        flashes << content_tag(:div, class: 'bg-green alert') do
          content_tag(:div, class: 'w-full max-w-screen-xl mx-auto py-4 px-6') do
            content_tag(:button, '&times;'.html_safe, class: 'close mr-4', data: { dismiss: 'alert', hidden: true }) +
              content_tag(:span, text)
          end
        end
      end
      flashes.html_safe
    end
  end
end
