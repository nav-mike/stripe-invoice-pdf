# frozen_string_literal: true

require 'stripe_invoice_pdf/invoice'
require 'stripe_invoice_pdf/railtie'
require 'stripe_invoice_pdf/version'
require 'wicked_pdf'

class StripeInvoicePdf
  @@config = {}

  cattr_accessor :config

  def self.api_key
    config[:api_key]
  end

  def self.company_logo
    config[:company_logo]
  end
end
