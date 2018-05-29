# frozen_string_literal: true

require 'stripe_invoice_pdf/helpers'

class StripeInvoicePdf
  if defined?(Rails.env)
    if Rails::VERSION::MAJOR >= 5
      initializer 'stripe_invoice_pdf.register' do |_app|
        ActionView::Base.send :include, StripeInvoicePdf::Helpers
      end
    elsif Rails::VERSION::MAJOR == 4
      ActionView::Base.send :include, StripeInvoicePdf::Helpers
    end
  end
end
