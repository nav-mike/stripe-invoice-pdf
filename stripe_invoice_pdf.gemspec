# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'stripe_invoice_pdf/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'stripe_invoice_pdf'
  s.version     = StripeInvoicePdf::VERSION
  s.authors     = ['Mikhail Navrotskiy', 'Vladislav Drannikov']
  s.email       = ['mikhail.navrotskiy@justwebit.ru', 'vladislav.drannikov@justwebit.ru']
  s.homepage    = 'https://github.com/nav-mike/stripe-invoice-pdf'
  s.summary     = 'Simple stripe invoice pdf generator for rails'
  s.description = 'Simple stripe invoice pdf generator for rails'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 4.2.1'
  s.add_dependency 'stripe', '~> 3.13.0'
  s.add_dependency 'wicked_pdf', '~> 1.1.0'
  s.add_dependency 'wkhtmltopdf-binary-edge', '~> 0.12.4.0'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'sqlite3'
end
