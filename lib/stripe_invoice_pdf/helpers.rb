# frozen_string_literal: true

class StripeInvoicePdf
  module Helpers
    def logo_svg(name = nil)
      logo_svg_file(name) if name
      raise 'Insert SVG here!' unless block_given?
      yield
    end

    private

    def logo_svg_file(name)
      path = "#{Rails.root}/app/assets/images/#{name}.svg"
      return File.read(path).html_safe if File.exist?(path)
      '(not found)'
    end
  end
end
