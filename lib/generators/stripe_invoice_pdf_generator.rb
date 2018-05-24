if defined?(Rails)
  class StripeInvoicePdfGenerator < Rails::Generators::Base
    source_root(File.expand_path(File.dirname(__FILE__) + '/../templates'))
    
    def copy_initializer
      copy_file 'stripe_invoice_pdf.rb', 'config/initializers/stripe_invoice_pdf.rb'
      
      inject_into_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do
          "\n\tget 'invoices/:invoice_id' => 'invoices_controller#show', constraints: {invoice_id: /[a-z0-9\_]+/i}"
      end
    end
  end
end