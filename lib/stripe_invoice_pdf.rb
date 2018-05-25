require 'stripe_invoice_pdf/invoice'

class StripeInvoicePdf
  @@config = {}

  cattr_accessor :config
  
  def self.api_key
    config[:api_key]
  end
end
