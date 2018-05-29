# frozen_string_literal: true

class StripeInvoicePdf
  module Helpers
    def invoice_logo_tag
      return yield if block_given?
      name = StripeInvoicePdf.company_logo
      exts = %w[.jpg .png .jpeg]
      return image_logo(name) if exts.include?(File.extname(name))
      logo_svg name
    end

    private

    def logo_svg_file(name)
      path = "#{Rails.root}/app/assets/images/#{name}.svg"
      return File.read(path).html_safe if File.exist?(path)
      '(not found)'
    end

    def image_logo(name)
      image_tag name
    end

    def logo_svg(name = nil)
      return logo_svg_file(name) if name
      raise 'Insert SVG here!' unless block_given?
      yield
    end
  end
end
