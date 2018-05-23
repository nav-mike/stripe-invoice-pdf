if defined?(Rails)
  class StripeInvoicePdfGenerator < Rails::Generators::Base
    source_root(File.expand_path(File.dirname(__FILE__) + '/../templates'))
    
    def copy_initializer
      copy_file 'stripe_invoice_pdf.rb', 'config/initializers/stripe_invoice_pdf.rb'
    end
  end
end