# frozen_string_literal: true

if defined?(Rails)
  class StripeInvoicePdfGenerator < Rails::Generators::Base
    source_root(File.expand_path(File.dirname(__FILE__) + '/../templates'))

    def copy_initializer
      copy_file 'stripe_invoice_pdf.rb', 'config/initializers/stripe_invoice_pdf.rb'

      inject_into_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do
        "\n  get 'invoices/:invoice_id' => 'invoices#show', constraints: {invoice_id: /[a-z0-9\_]+/i}"
      end

      append_to_file 'config/initializers/assets.rb' do
        "Rails.application.config.assets.precompile += %w( stripe_invoice_pdf.css )\n"
      end

      inject_into_class 'config/application.rb', 'Application' do
        "    config.assets.precompile << /\.(?:ttf)\z/\n"
      end

      copy_file 'app/controllers/invoices_controller.rb'

      copy_file 'app/views/invoices/show.html.erb'
      copy_file 'app/views/layouts/stripe_invoice_pdf/pdf.html.erb'

      copy_file 'app/assets/stylesheets/stripe_invoice_pdf.css'
      copy_file 'app/assets/stylesheets/bootstrap.min.css'

      copy_file 'app/assets/fonts/Lato-Regular.ttf'

      generate 'wicked_pdf'
    end
  end
end
