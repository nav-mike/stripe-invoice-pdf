# frozen_string_literal: true

require 'stripe_invoice_pdf/helpers'

class StripeInvoicePdf
  if defined?(Rails.env)
    if Rails::VERSION::MAJOR >= 5
      class StripeInvoicePdfRailtie < Rails::Railtie
        initializer 'stripe_invoice_pdf.register' do |_app|
          ActionView::Base.send :include, StripeInvoicePdf::Helpers
        end
      end
    elsif Rails::VERSION::MAJOR == 4
      class StripeInvoicePdfRailtie < Rails::Railtie
        initializer 'stripe_invoice_pdf.register' do |_app|
          ActionView::Base.send :include, StripeInvoicePdf::Helpers
        end
      end
    end
  end
end
